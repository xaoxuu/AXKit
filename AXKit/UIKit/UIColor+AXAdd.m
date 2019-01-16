//
//  UIColor+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIColor+AXAdd.h"

static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [[str stringByTrimmingCharactersInSet:set] lowercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0x"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

static CGFloat safePercentValue(CGFloat p){
    return MAX(MIN(p, 1), 0);
}
static inline UIColor *darken(UIColor *color, CGFloat percent){
    CGFloat p = safePercentValue(percent);
    CGFloat red = 0.0,green = 0.0,blue = 0.0, alpha = 1.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    red   = red   * (1 - p);
    green = green * (1 - p);
    blue  = blue  * (1 - p);
    return [color.class colorWithRed:red green:green blue:blue alpha:percent];
}
static inline UIColor *lighten(UIColor *color, CGFloat percent){
    CGFloat p = safePercentValue(percent);
    CGFloat red = 0.0,green = 0.0,blue = 0.0, alpha = 1.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    red   = p + red   * (1 - p);
    green = p + green * (1 - p);
    blue  = p + blue  * (1 - p);
    return [color.class colorWithRed:red green:green blue:blue alpha:alpha];
}

static inline NSString *hexStringWithAlpha(UIColor *color, BOOL useAlpha){
    CGColorRef colorRef = color.CGColor;
    size_t count = CGColorGetNumberOfComponents(colorRef);
    const CGFloat *components = CGColorGetComponents(colorRef);
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
    
    if (hex && useAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(color.alphaValue * 255.0 + 0.5)];
    }
    return hex;
}
static inline CGFloat grayLevel(UIColor *color){
    CGFloat red = 0.0,green = 0.0,blue = 0.0, alpha = 1.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return red * 0.299 + green * 0.587 + blue * 0.114;
}


static inline void smartRGBA(CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a){
    if (*r <= 1 && *g <= 1 && *b <= 1) {
        // 传入的是0~1
    } else if (*r <= 255 && *g <= 255 && *b <= 255) {
        // 传入的是0~255
        *r /= 255.0;
        *g /= 255.0;
        *b /= 255.0;
    }
    if (a != nil) {
        if (*a > 1 && *a <= 255) {
            *a /= 255.0;
        }
    }
}
@implementation UIColor (AXAdd)


- (__kindof UIColor *)dark{
    return darken(self, 0.48);
}
- (__kindof UIColor *(^)(CGFloat ratio))darken{
    return ^(CGFloat ratio){
        return darken(self, ratio);
    };
}
- (__kindof UIColor *)light{
    return lighten(self, 0.6);
}

- (__kindof UIColor *(^)(CGFloat ratio))lighten{
    return ^(CGFloat ratio){
        return lighten(self, ratio);
    };
}

+ (__kindof UIColor *)randomColor{
    return [self colorWithRed:(float)(arc4random()%256)/256 green:(float)(arc4random()%256)/256 blue:(float)(arc4random()%256)/256 alpha:1.0];
}


// color with hex string
+ (instancetype)colorWithHex:(NSString *)hex{
    CGFloat r, g, b, a;
    if (hexStrToRGBA(hex, &r, &g, &b, &a)) {
        return [self colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}
+ (instancetype)colorWithSmartRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    smartRGBA(&red, &green, &blue, &alpha);
    return [self colorWithRed:red green:green blue:blue alpha:alpha];
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

- (CGFloat)hueValue {
    CGFloat h = 0, s, b, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return h;
}

- (CGFloat)saturationValue {
    CGFloat h, s = 0, b, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return s;
}

- (CGFloat)brightnessValue {
    CGFloat h, s, b = 0, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return b;
}

- (NSString *)hexString {
    return hexStringWithAlpha(self, NO);
}

- (NSString *)hexStringWithAlpha {
    return hexStringWithAlpha(self, YES);
}

- (CGFloat)grayLevel{
    return grayLevel(self);
}

- (BOOL)isLightColor{
    if (grayLevel(self) >= 192.0/255.0) {
        // @xaoxuu: light color
        return YES;
    } else {
        // @xaoxuu: dark color
        return NO;
    }
}

- (UIColor *)adaptive{
    if (self.isLightColor) {
        return self.dark;
    } else {
        return self;
    }
}

@end
