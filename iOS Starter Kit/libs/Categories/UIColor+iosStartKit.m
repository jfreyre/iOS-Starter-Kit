//
//  UIColor+iosStartKit.h
//  iOS Starter Kit
//
//  Created by Jérome Freyre on 28.03.13.
//  Copyright (c) 2013 YourOrganizationName. All rights reserved.
//

#import "UIColor+iosStartKit.h"

@implementation UIColor (iosStartKit)

+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha {
    
    //Setup a default color if we run into any problems
    UIColor *defaultColor = [UIColor clearColor];
    
    //Check to make sure we have a valid hex value
    if ([hex characterAtIndex:0] != '#') {
        NSString *poundHex = @"#";
        poundHex = [poundHex stringByAppendingString:hex];
        hex = poundHex;
    }
    
    // if hex is less than 7 characters return the default color
    if ([hex length] < 7) {
        return defaultColor;
    }
    
    //If the hex value is over 7, trim it down
    if ([hex length] > 7) {
        hex = [hex substringToIndex:7];
    }
    
    //Split the hex value into parts to test a valid hex value
    NSArray *hexParts = [hex componentsSeparatedByString:@"#"];
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    if ([hexParts count] == 2) {
        BOOL valid = [[[hexParts objectAtIndex:1] stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
        if (valid == NO) {
            return defaultColor;
        }
    } else {
        return defaultColor;
    }
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(1, 2)]];
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(3, 2)]];
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(5, 2)]];
    
    unsigned redInt = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:redHex];
    [rScanner scanHexInt:&redInt];
    
    unsigned greenInt = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:greenHex];
    [gScanner scanHexInt:&greenInt];
    
    unsigned blueInt = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:blueHex];
    [bScanner scanHexInt:&blueInt];
    
    return [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
}

+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
