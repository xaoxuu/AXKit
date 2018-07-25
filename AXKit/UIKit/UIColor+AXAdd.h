//
//  UIColor+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

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
- (__kindof UIColor *)darken:(CGFloat)ratio;
/**
 颜色变浅，传入参数ratio为比例（0~1）
 */
- (__kindof UIColor *)lighten:(CGFloat)ratio;

/**
 随机色

 @return 随机色
 */
+ (__kindof UIColor *)randomColor;

/**
 以HEX字符串创建颜色
 
 @param hex hex
 @return UIColor实例
 */
+ (instancetype)colorWithHex:(NSString *)hex;

/**
 以rgba创建颜色，传入的rgba可为0~1的值，也可为0~255的值，但同时只能传入一种类型（全部0~1或者全部0~255）的值。

 @param red red
 @param green green
 @param blue blue
 @param alpha alpha
 @return UIColor实例
 */
+ (instancetype)colorWithSmartRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

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
