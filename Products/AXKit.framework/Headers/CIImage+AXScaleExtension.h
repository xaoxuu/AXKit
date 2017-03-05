//
//  CIImage+AXScaleExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface CIImage (AXScaleExtension)

/**
 创建一个缩放后的图片

 @param widthAndHeight 图片宽高

 @return 图片
 */
- (UIImage *)ax_createNonInterpolatedWithWidthAndHeight:(CGFloat)widthAndHeight;


/**
 创建一个缩放后的图片

 @param scale 缩放比例

 @return 图片
 */
- (UIImage *)ax_createNonInterpolatedWithScale:(CGFloat)scale;


/**
 创建一个缩放后的图片

 @param size 图片尺寸

 @return 图片
 */
- (UIImage *)ax_createNonInterpolatedWithCGSize:(CGSize)size;


@end

