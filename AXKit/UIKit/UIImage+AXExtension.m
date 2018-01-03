//
//  UIImage+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIImage+AXExtension.h"
#import <CoreImage/CoreImage.h>

#pragma mark - 生成


inline UIImage *UIImageGetPureColorImage(UIColor *color, CGSize size, CGFloat alpha){
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *pureColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pureColorImage;
}


inline UIImage *UIImageFromView(UIView *view){
    // @xaoxuu: 开始取图
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    // @xaoxuu: 将图层放入上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // @xaoxuu: 取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // @xaoxuu: 结束取图
    UIGraphicsEndImageContext();
    return image;
}

inline UIImage *UIImageNamed(NSString *name){
    UIImage *image = [UIImage imageNamed:name];
    if (!image) {
        NSData *data = [NSData dataWithContentsOfFile:name];
        image = [UIImage imageWithData:data];
    }
    return image;

}

inline UIImage *UIImageWithBundleImageName(NSString *name){
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    if (!path) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
    }
    if (!path) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"jpeg"];
    }
    if (!path) {
        
    }
    return [UIImage imageWithContentsOfFile:path];
}

inline NSArray<UIImage *> *UIImagesWithBundleImageNames(NSString *name, NSUInteger count){
    NSMutableArray<UIImage *> *array = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        name = [name stringByAppendingFormat:@"%d",i];
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
        }
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:name ofType:@"jpeg"];
        }
        if (!path) {
            
        }
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        if (image) {
            [array addObject:image];
        }
    }
    if (array.count) {
        return array;
    } else{
        return nil;
    }
}






#pragma mark - 加工

static inline UIImage *UIImageGetSquareImageAndOption(UIImage *image, void(^op)(CGContextRef ctx, CGRect rect)){
    // begin context
    UIGraphicsBeginImageContext(image.size);
    // context ref
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // add a circle
    CGFloat max = fmax(image.size.width, image.size.height);
    CGRect rect = CGRectMake(0.5*(image.size.width-max), 0.5*(image.size.height-max), max, max);
    // other option
    if (op) {
        op(ctx, rect);
    }
    // clip
    CGContextClip(ctx);
    // draw
    [image drawInRect:rect];
    // get circle image
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    // close context
    UIGraphicsEndImageContext();
    return roundedImage;
}
inline UIImage *UIImageGetSquareImage(UIImage *image){
    return UIImageGetSquareImageAndOption(image, nil);
}
inline UIImage *UIImageGetRoundedImage(UIImage *image){
    return UIImageGetSquareImageAndOption(image, ^(CGContextRef ctx, CGRect rect) {
        CGContextAddEllipseInRect(ctx, rect);
    });
}


inline UIImage *UIImageGetBlurredImage(UIImage *image, CGFloat ratio){
    CIImage * ciImage = [[CIImage alloc]initWithImage:image];
    CIFilter* blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    [blurFilter setValue:@(ratio) forKey:@"inputRadius"];
    CIImage* outImage = [blurFilter valueForKey:kCIOutputImageKey];
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef outCGImage = [context createCGImage:outImage fromRect:[outImage extent]];
    UIImage* blurredImage = [UIImage imageWithCGImage:outCGImage];
    CGImageRelease(outCGImage);
    return blurredImage;
}

inline void UIImageBlurImageAsync(UIImage *image, CGFloat ratio, void (^completion)(UIImage *image)){
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // @xaoxuu: in background queue
        UIImage *blurredImage = UIImageGetBlurredImage(image, ratio);
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // @xaoxuu: in background queue
                completion(blurredImage);
            });
        }
    });
}



#pragma mark 缩放


inline UIImage *UIImageNonInterpolatedScaleWithRatio(UIImage *image, CGFloat ratio){
    CGRect extent = CGRectIntegral(image.CIImage.extent);
    
    // create bitmap;
    size_t width = CGRectGetWidth(extent) * ratio;
    size_t height = CGRectGetHeight(extent) * ratio;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image.CIImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, ratio, ratio);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // save bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


inline UIImage *UIImageNonInterpolatedScaleWithLength(UIImage *image, CGFloat length){
    CGRect extent = CGRectIntegral(image.CIImage.extent);
    CGFloat scale = fmin(length/CGRectGetWidth(extent), length/CGRectGetHeight(extent));
    return UIImageNonInterpolatedScaleWithRatio(image, scale);
}

inline UIImage *UIImageNonInterpolatedScaleWithCGSize(UIImage *image, CGSize size){
    CGRect extent = CGRectIntegral(image.CIImage.extent);
    CGFloat scale = fmin(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    return UIImageNonInterpolatedScaleWithRatio(image, scale);
}


@implementation UIImage (AXExtension)


#pragma mark - 生成

+ (UIImage *)ax_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha{
    return UIImageGetPureColorImage(color, size, alpha);
}

+ (UIImage *)ax_imageWithView:(UIView *)view{
    return UIImageFromView(view);
}

+ (UIImage *)ax_imageWithBundleImageName:(NSString *)name{
    return UIImageWithBundleImageName(name);
}

+ (NSArray<UIImage *> *)ax_imageWithBundleImageName:(NSString *)name count:(NSUInteger)count{
    return UIImagesWithBundleImageNames(name, count);
}





#pragma mark - 加工

- (UIImage *)ax_squareImage{
    return UIImageGetSquareImage(self);
}

- (UIImage *)ax_roundedImage{
    return UIImageGetRoundedImage(self);
}

- (UIImage *)ax_blurEffectWithFactor:(CGFloat)ratio{
    return UIImageGetBlurredImage(self, ratio);
}

- (void)ax_blurEffectWithFactor:(CGFloat)ratio completion:(void (^)(UIImage *image))completion {
    UIImageBlurImageAsync(self, ratio, completion);
}

@end
