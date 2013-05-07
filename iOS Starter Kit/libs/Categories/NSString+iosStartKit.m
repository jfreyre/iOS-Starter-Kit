//
//  NSString+iosStartKit.h
//  iOS Starter Kit
//
//  Created by Jérome Freyre on 28.03.13.
//  Copyright (c) 2013 YourOrganizationName. All rights reserved.
//

#import "NSString+iosStartKit.h"

@implementation NSString (iosStartKit)


-(NSString*) slugify {
    // Remove non-word and non-digit
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\w\\d]+"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@"-"];
    
    // convert to a data object, using a lossy conversion to ASCII
    NSData *asciiEncoded = [modifiedString dataUsingEncoding:NSASCIIStringEncoding
                                        allowLossyConversion:YES];
    
    // take the data object and recreate a string using the lossy conversion
    NSString *other = [[NSString alloc] initWithData:asciiEncoded
                                            encoding:NSASCIIStringEncoding];
    
    return [other lowercaseString];
}

- (BOOL)isEmail
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
