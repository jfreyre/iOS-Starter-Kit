//
//  MMWebViewController.h
//  MarinaMobile
//
//  Created by Jérome Freyre on 14.02.13.
//  Copyright (c) 2013 La Vaudoise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMWebViewController : UIViewController<UIWebViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSURL * url;

@property (nonatomic, strong) IBOutlet UIWebView * webview;

@property (nonatomic, strong) IBOutlet UIToolbar* toolbar;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* backButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* forwardButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* refreshButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* actionButton;

- (IBAction)shareAction;
- (IBAction)backAction;
- (IBAction)forwardAction;
- (IBAction)refreshAction;
@end
