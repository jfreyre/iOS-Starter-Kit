//
//  NSString+MarinaCustoms.h
//  MarinaMobile
//
//  Created by Jérome Freyre on 23.01.13.
//  Copyright (c) 2013 La Vaudoise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (iosStartKit)

// wrapper for [UIColor colorWithRed:green:blue:alpha:]
// values must be in range 0 - 255
+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

// Creates color using hex representation
// hex - must be in format: #FF00CC
// alpha - must be in range 0.0 - 1.0
+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha;

+ (UIImage *)imageFromColor:(UIColor *)color;


@end
