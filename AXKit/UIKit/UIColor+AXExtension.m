//
//  UIColor+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIColor+AXExtension.h"

static CGFloat static_color_ratio = 0.6;

@implementation UIColor (AXExtension)


- (UIColor *)dark{
    CGFloat red = 0.0,green = 0.0,blue = 0.0, alpha = 1.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    red   = red * (1-static_color_ratio*0.8);
    green = green * (1-static_color_ratio*0.8);
    blue  = blue * (1-static_color_ratio*0.8);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
- (UIColor *(^)(CGFloat ratio))darkRatio{
    return ^(CGFloat ratio){
        CGFloat red = 0.0,green = 0.0,blue = 0.0, alpha = 1.0;
        [self getRed:&red green:&green blue:&blue alpha:&alpha];
        red   = red   * (1 - ratio);
        green = green * (1 - ratio);
        blue  = blue  * (1 - ratio);
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    };
}

- (UIColor *)light{
    CGFloat red = 0.0,green = 0.0,blue = 0.0, alpha = 1.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    red   = static_color_ratio + red * (1-static_color_ratio);
    green = static_color_ratio + green * (1-static_color_ratio);
    blue  = static_color_ratio + blue * (1-static_color_ratio);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
- (UIColor *(^)(CGFloat ratio))lightRatio{
    return ^(CGFloat ratio){
        CGFloat red = 0.0,green = 0.0,blue = 0.0, alpha = 1.0;
        [self getRed:&red green:&green blue:&blue alpha:&alpha];
        red   = ratio + red   * (1 - ratio);
        green = ratio + green * (1 - ratio);
        blue  = ratio + blue  * (1 - ratio);
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    };
}

+ (UIColor *)randomColor{
    return [UIColor colorWithRed:(float)(arc4random()%256)/256 green:(float)(arc4random()%256)/256 blue:(float)(arc4random()%256)/256 alpha:1.0];
}


// color with hex
+ (UIColor *)colorWithHex:(NSUInteger)hex{
    return [UIColor
            colorWithRed:((CGFloat)((hex & 0xFF0000) >> 16))/ 255.0
            green:       ((CGFloat)((hex & 0xFF00) >> 8))   / 255.0
            blue:        ((CGFloat)(hex & 0xFF))            / 255.0
            alpha:1.0];
}
// color with hex string
+ (UIColor *)colorWithHexString:(NSString *)hexStr{
    float red = 0.0,green = 0.0,blue = 0.0,alpha = 1.0;
    if ([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
        NSScanner *scanner = [NSScanner scannerWithString:hexStr];
        unsigned long long hexValue = 0;
        if ([scanner scanHexLongLong:&hexValue]) {
            switch (hexStr.length) {
                case 3:
                    red = ((hexValue & 0xF00) >> 8) / 15.0;
                    green = ((hexValue & 0x0F0) >> 4) / 15.0;
                    blue = (hexValue & 0x00F) / 15.0;
                    break;
                case 4:
                    red = ((hexValue & 0xF000) >> 12) / 15.0;
                    green = ((hexValue & 0x0F00) >> 8) / 15.0;
                    blue = ((hexValue & 0x00F0) >> 4) / 15.0;
                    alpha = (hexValue & 0x000F) / 15.0;
                    break;
                case 6:
                    red = ((hexValue & 0xFF0000) >> 16) / 255.0;
                    green = ((hexValue & 0x00FF00) >> 8) / 255.0;
                    blue = (hexValue & 0x0000FF) / 255.0;
                    break;
                case 8:
                    red = ((hexValue & 0xFF000000) >> 24) / 255.0;
                    green = ((hexValue & 0x00FF0000) >> 16) / 255.0;
                    blue = ((hexValue & 0x0000FF00) >> 8) / 255.0;
                    alpha = (hexValue & 0x000000FF) / 255.0;
                    break;
                default:
                    NSLog(
                          @"🔴func:%s :Invalid RGB string: '%@', number of characters after '#' should "@"be " @"either 3, 4, 6 or 8", __func__ ,
                          hexStr);
            }
        } else {
            NSLog(@"🔴func:%s Scan hex error", __func__);
        }
    } else {
//        NSLog(@"🔴func:%s Invalid RGB string: '%@', missing '#' as prefix", __func__, hexStr);
        return [self colorWithHexString:[NSString stringWithFormat:@"#%@",hexStr]];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


- (CGFloat)redValue{
    CGFloat red;
    [self getRed:&red green:nil blue:nil alpha:nil];
    return red;
}
- (CGFloat)greenValue{
    CGFloat green;
    [self getRed:nil green:&green blue:nil alpha:nil];
    return green;
}
- (CGFloat)blueValue{
    CGFloat blue;
    [self getRed:nil green:nil blue:&blue alpha:nil];
    return blue;
}
- (CGFloat)alphaValue{
    CGFloat alpha;
    [self getRed:nil green:nil blue:nil alpha:&alpha];
    return alpha;
}


- (NSString *)hexString {
    return [self hexStringWithAlpha:NO];
}

- (NSString *)hexStringWithAlpha {
    return [self hexStringWithAlpha:YES];
}

- (NSString *)hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(CGColorGetAlpha(self.CGColor) * 255.0 + 0.5)];
    }
    return hex;
}


- (CGFloat)grayLevel{
    CGFloat r = self.redValue;
    CGFloat g = self.greenValue;
    CGFloat b = self.blueValue;
    
    return r * 0.299 + g * 0.587 + b * 0.114;
}

- (BOOL)isLightColor{
    
    if (self.grayLevel >= 192.0/255.0) {
        // @xaoxuu: light color
        return YES;
    } else {
        // @xaoxuu: dark color
        return NO;
    }
    
}


@end
