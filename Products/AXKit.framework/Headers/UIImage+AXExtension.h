//
//  UIImage+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AXExtension)

#pragma mark - load image

/**
 从bundle中读取图片（自动追加.png/.jpg/.jpeg扩展名）

 @param name 图片名

 @return 图片
 */
+ (UIImage *)ax_imageWithBundleImageName:(NSString *)name;


/**
 从bundle中读取一组图片（自动追加.png/.jpg/.jpeg扩展名）
 
 @param name  图片名（image,不含序号）
 @param count 图片数量
 
 @return 图片<image0,image1,image2, ...>
 */
+ (NSArray<UIImage *> *)ax_imageWithBundleImageName:(NSString *)name count:(NSUInteger)count;

#pragma mark - convert a rectangle image to circle image

/**
 把图片剪裁为圆形

 @return 图片
 */
- (UIImage *)ax_roundedImage;


#pragma mark - create a purity image

/**
 创建一个纯色图片

 @param color 颜色
 @param size  尺寸
 @param alpha alpha值

 @return 图片
 */
+ (UIImage *)ax_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;

#pragma mark - get blur effect image

/**
 毛玻璃效果

 @param factor 毛玻璃效果指数

 @return 毛玻璃效果处理后的图片
 */
- (UIImage *)ax_blurEffectWithFactor:(CGFloat)factor;

/**
 毛玻璃效果
 
 @param factor     毛玻璃效果指数
 @param completion 处理完成后执行的block 
 */

- (void)ax_blurEffectWithFactor:(CGFloat)factor completion:(void (^)(UIImage *image))completion;


@end




