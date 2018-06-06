//
//  UIImage+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
#pragma mark - 生成

/**
 创建一个纯色图片
 
 @param color 颜色
 @param size  尺寸
 @param alpha alpha值
 
 @return 图片
 */
CG_EXTERN UIImage *UIImageGetPureColorImage(UIColor *color, CGSize size, CGFloat alpha);


/**
 将view转换成图片
 
 @param view view
 @return 图片
 */
CG_EXTERN UIImage *UIImageFromView(UIView *view);



/**
 从assets里读取图片

 @param name 图片名
 @return 图片
 */
CG_EXTERN UIImage * _Nullable UIImageNamed(NSString *name);

/**
 从bundle中读取图片（自动加.png/.jpg/.jpeg扩展名）
 
 @param name 图片名
 @return 图片
 */
CG_EXTERN UIImage * _Nullable UIImageWithBundleImageName(NSString *name);


/**
 从bundle中读取若干图片
 
 @param name 图片名（image,不含序号）
 @param count 图片数量
 @return 图片<image0,image1,image2, ...>
 */
CG_EXTERN NSArray<UIImage *> * _Nullable UIImagesWithBundleImageNames(NSString *name, NSUInteger count);


#pragma mark - 加工

#pragma mark 剪裁

/**
 把图片剪裁为正方形
 
 @return 图片
 */
CG_EXTERN UIImage *UIImageGetSquareImage(UIImage *image);

/**
 把图片剪裁为圆形
 
 @return 图片
 */
CG_EXTERN UIImage *UIImageGetRoundedImage(UIImage *image);

#pragma mark 模糊

/**
 毛玻璃效果
 
 @param ratio 毛玻璃效果指数
 
 @return 毛玻璃效果处理后的图片
 */
CG_EXTERN UIImage *UIImageGetBlurredImage(UIImage *image, CGFloat ratio);

/**
 异步绘制毛玻璃效果
 
 @param ratio     毛玻璃效果指数
 @param completion 处理完成的回调
 */
CG_EXTERN void UIImageBlurImageAsync(UIImage *image, CGFloat ratio, void (^completion)(UIImage *image));




#pragma mark 缩放


/**
 等比缩放

 @param image 图片
 @param ratio 比例
 @return 缩放后的图片
 */
CG_EXTERN UIImage *UIImageNonInterpolatedScaleWithRatio(UIImage *image, CGFloat ratio);


/**
 缩放到某个长度

 @param image 图片
 @param length 边长
 @return 缩放后的图片
 */
CG_EXTERN UIImage *UIImageNonInterpolatedScaleWithLength(UIImage *image, CGFloat length);


/**
 缩放到某个长宽比

 @param image 图片
 @param size 长宽
 @return 缩放后的图片
 */
CG_EXTERN UIImage *UIImageNonInterpolatedScaleWithCGSize(UIImage *image, CGSize size);



@interface UIImage (AXExtension)

#pragma mark - 生成

/**
 创建一个纯色图片
 
 @param color 颜色
 @param size  尺寸
 @param alpha alpha值
 
 @return 图片
 */
+ (UIImage *)ax_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;


/**
 将view转换成图片
 
 @param view view
 @return 图片
 */
+ (UIImage *)ax_imageWithView:(UIView *)view;


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

#pragma mark - 加工

/**
 把图片剪裁为正方形
 
 @return 图片
 */
- (UIImage *)ax_squareImage;

/**
 把图片剪裁为圆形

 @return 图片
 */
- (UIImage *)ax_roundedImage;

/**
 毛玻璃效果

 @param ratio 毛玻璃效果指数

 @return 毛玻璃效果处理后的图片
 */
- (UIImage *)ax_blurEffectWithFactor:(CGFloat)ratio;

/**
 毛玻璃效果
 
 @param ratio     毛玻璃效果指数
 @param completion 处理完成后执行的block 
 */

- (void)ax_blurEffectWithFactor:(CGFloat)ratio completion:(void (^)(UIImage *image))completion;


@end

NS_ASSUME_NONNULL_END
