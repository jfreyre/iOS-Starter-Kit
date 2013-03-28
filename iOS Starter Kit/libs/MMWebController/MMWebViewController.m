//
//  MMWebViewController.m
//  MarinaMobile
//
//  Created by Jérome Freyre on 14.02.13.
//  Copyright (c) 2013 La Vaudoise. All rights reserved.
//

#import "MMWebViewController.h"

@interface MMWebViewController ()

@end

@implementation MMWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURLRequest *requestObj = [NSURLRequest requestWithURL:_url];
    [_webview loadRequest:requestObj];
	[_webview sizeToFit];
	[_webview setScalesPageToFit:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark Webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
	
	_backButton.enabled = [_webview canGoBack] ? YES : NO;
	_forwardButton.enabled = [_webview canGoForward] ? YES : NO;
    
    
	[_webview autoresizesSubviews];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[_webview setHidden:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	NSLog(@"-> Webview error: %@", [error description]);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Impossible de charger la page...", @"MMWebView")];
}

#pragma mark
#pragma mark Actions
- (IBAction)shareAction {
	UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self
											   cancelButtonTitle:NSLocalizedString(@"Annuler", @"MMWebView")
										  destructiveButtonTitle:nil
											   otherButtonTitles:NSLocalizedString(@"Ouvrir dans Safari", @"MMWebView"),
                             NSLocalizedString(@"Envoyer par mail", @"MMWebView"),
                             NSLocalizedString(@"Copier", @"MMWebView"), nil] ;
	[sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([_webview isLoading]) {
		return;
	}
	if (buttonIndex == 0) {
        
		[[UIApplication sharedApplication] openURL:self.url];
	} else if (buttonIndex == 1){
		NSString *recipients = @"mailto:?";
		NSString *body = [@"body=" stringByAppendingString:[_webview.request.URL absoluteString]];
		
		NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
		email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
	} else if (buttonIndex == 2) {
		UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
		pasteboard.string = [_webview.request.URL absoluteString];
	}
    
}

- (IBAction)backAction {
	[_webview goBack];
}

- (IBAction)forwardAction {
	[_webview goForward];
}

- (IBAction)refreshAction {
	[_webview reload];
}
@end
