//
//  UIImageView+AXGetColor.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (AXGetColor)


#pragma mark - 从指定CGPoint获取UIColor

#pragma mark 推荐用于圆形取色板
/**
 从圆形范围内的指定点获取UIColor对象，并在block中执行操作
 
 @param point      指定坐标点
 @param completion 取色完成后执行的block
 */
- (void)ax_getColorFromCircleWithPoint:(CGPoint)point completion:(void (^)(UIColor *color))completion;

/**
 从圆形范围内的指定点获取RGBA值，并在block中执行操作
 
 @param point      指定坐标点
 @param completion 取色完成后执行的block
 */
- (void)ax_getRGBAFromCircleWithPoint:(CGPoint)point completion:(void (^)(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha))completion;

#pragma mark 推荐用于方形取色板

/**
 从指定点获取UIColor对象，并在block中执行操作
 
 @param point      指定坐标点
 @param completion 取色完成后执行的block
 */
- (void)ax_getColorWithPoint:(CGPoint)point completion:(void(^)(UIColor *color))completion;

/**
 从指定点获取RGBA值，并在block中执行操作
 
 @param point      指定坐标点
 @param completion 取色完成后执行的block
 */
- (void)ax_getRGBAWithPoint:(CGPoint)point completion:(void(^)(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha))completion;

#pragma mark 返回值可空，操作繁琐，不推荐用

/**
 从指定点获取UIColor对象（最原始最暴力的方法，不推荐用）
 
 @param point 指定坐标点
 
 @return UIColor对象（可空）
 */
- (nullable UIColor *)ax_getColorWithPoint:(CGPoint)point;

/**
 从指定点获取RGBA值（最原始最暴力的方法，不推荐用）

 @param red   red
 @param green green
 @param blue  blue
 @param alpha alpha
 @param point 指定坐标点
 */
- (void)ax_getRed:(nullable CGFloat *)red green:(nullable CGFloat *)green blue:(nullable CGFloat *)blue alpha:(nullable CGFloat *)alpha withPoint:(CGPoint)point;






@end

NS_ASSUME_NONNULL_END
