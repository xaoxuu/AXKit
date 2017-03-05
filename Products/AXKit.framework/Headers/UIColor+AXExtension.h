//
//  UIColor+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AXExtension)


- (UIColor *)dark;

- (UIColor *)light;

- (UIColor *(^)(CGFloat))darkRatio;

- (UIColor *(^)(CGFloat))lightRatio;

+ (UIColor *)randomColor;

+ (UIColor *)colorWithHex:(NSUInteger)hex;

+ (UIColor *)colorWithHexString:(NSString *)hexStr;

- (CGFloat)getRed;

- (CGFloat)getGreen;

- (CGFloat)getBlue;

- (CGFloat)getAlpha;

- (NSString *)hexString;

- (NSString *)hexStringWithAlpha;



@end



