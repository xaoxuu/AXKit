//
//  UIColor+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 更改状态栏背景色

 @param color 颜色
 */
CG_EXTERN void AppSetStatusBarBackgroundColor(UIColor *color);



@interface UIColor (AXExtension)


/**
 颜色变深

 @return 变深之后的颜色
 */
- (UIColor *)dark;

/**
 颜色变浅

 @return 变浅之后的颜色
 */
- (UIColor *)light;

/**
 颜色变深，传入参数ratio为比例（0~1）
 */
- (UIColor *(^)(CGFloat ratio))darkRatio;

/**
 颜色变浅，传入参数ratio为比例（0~1）
 */
- (UIColor *(^)(CGFloat ratio))lightRatio;


/**
 随机色

 @return 随机色
 */
+ (UIColor *)randomColor;

/**
 以HEX创建颜色

 @param hex 16进制
 @return UIColor实例
 */
+ (UIColor *)colorWithHex:(NSUInteger)hex;

/**
 以HEX字符串创建颜色

 @param hexStr HEX字符串
 @return UIColor实例
 */
+ (UIColor *)colorWithHexString:(NSString *)hexStr;

/**
 获取UIColor中的R值

 @return R值（0~1）
 */
- (CGFloat)redValue;

/**
 获取UIColor中的G值
 
 @return R值（0~1）
 */
- (CGFloat)greenValue;

/**
 获取UIColor中的B值
 
 @return R值（0~1）
 */
- (CGFloat)blueValue;

/**
 获取UIColor中的Alpha值
 
 @return R值（0~1）
 */
- (CGFloat)alphaValue;


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
 粗略判断颜色是不是浅色调

 @return 是不是浅色
 */
- (BOOL)isLightColor;






@end
