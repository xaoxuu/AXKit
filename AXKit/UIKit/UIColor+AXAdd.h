//
//  UIColor+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 颜色加深

 @param color 颜色
 @param percent 加深比例（0~1）
 @return 加深之后的颜色
 */
CG_EXTERN __kindof UIColor *darken(UIColor *color, CGFloat percent);

/**
 颜色变浅

 @param color 颜色
 @param percent 变浅比例（0~1）
 @return 变浅之后的颜色
 */
CG_EXTERN __kindof UIColor *lighten(UIColor *color, CGFloat percent);

@interface UIColor (AXAdd)


/**
 颜色变深，默认比例0.48

 @return 变深之后的颜色
 */
- (__kindof UIColor *)dark;

/**
 颜色变浅，默认比例0.6

 @return 变浅之后的颜色
 */
- (__kindof UIColor *)light;

/**
 颜色变深，传入参数ratio为比例（0~1）
 */
- (__kindof UIColor *(^)(CGFloat ratio))darken;

/**
 颜色变浅，传入参数ratio为比例（0~1）
 */
- (__kindof UIColor *(^)(CGFloat ratio))lighten;


/**
 随机色

 @return 随机色
 */
+ (__kindof UIColor *)randomColor;

/**
 以HEX字符串创建颜色
 
 @return UIColor实例
 */
+ (__kindof UIColor *(^)(NSString *))initWithHEX;

/**
 以RGB创建颜色
 */
+ (__kindof UIColor *(^)(CGFloat red, CGFloat green, CGFloat blue))initWithRGB;

/**
 以RGBA创建颜色
 */
+ (__kindof UIColor *(^)(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha))initWithRGBA;

/**
 以RGBA创建颜色
 */
+ (__kindof UIColor *(^)(CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha))initWithHSBA;

/**
 以white和alpha创建颜色
 */
+ (__kindof UIColor *(^)(CGFloat white, CGFloat alpha))initWithWhite;

/**
 获取UIColor中的R值

 @return R值（0~1）
 */
- (CGFloat)redValue;

/**
 获取UIColor中的G值
 
 @return G值（0~1）
 */
- (CGFloat)greenValue;

/**
 获取UIColor中的B值
 
 @return B值（0~1）
 */
- (CGFloat)blueValue;

/**
 获取UIColor中的Alpha值
 
 @return A值（0~1）
 */
- (CGFloat)alphaValue;

/**
 色相

 @return 色相
 */
- (CGFloat)hueValue;

/**
 饱和度

 @return 饱和度
 */
- (CGFloat)saturationValue;

/**
 亮度

 @return 亮度
 */
- (CGFloat)brightnessValue;

/**
 获取颜色的HEX字符串（不含Alpha值）

 @return HEX字符串
 */
- (NSString *)hexString;

/**
 获取颜色的HEX字符串
 
 @return HEX字符串
 */
- (NSString *)hexStringWithAlpha;

/**
 灰度

 @return 灰度
 */
- (CGFloat)grayLevel;

/**
 粗略判断颜色是不是浅色调

 @return 是不是浅色
 */
- (BOOL)isLightColor;


- (UIColor *)adaptive;



@end
