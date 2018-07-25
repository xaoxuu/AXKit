//
//  UIImage+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIImage+AXAdd.h"
#import <CoreImage/CoreImage.h>
#import "UIColor+AXAdd.h"
#pragma mark - 生成

static inline UIImage *UIImageGetPureColorImage(UIColor *color, CGSize size){
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, color.alphaValue);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *pureColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pureColorImage;
}

static inline UIImage *UIImageFromView(UIView *view){
    // @xaoxuu: 开始取图
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    // @xaoxuu: 将图层放入上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    // @xaoxuu: 取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // @xaoxuu: 结束取图
    UIGraphicsEndImageContext();
    return image;
}

static inline UIImage *UIImageWithBundleImageName(NSBundle *bundle, NSString *name){
    NSString *path = [bundle pathForResource:name ofType:@"png"];
    if (!path) {
        path = [bundle pathForResource:name ofType:@"jpg"];
    }
    if (!path) {
        path = [bundle pathForResource:name ofType:@"jpeg"];
    }
    if (!path) {
        
    }
    return [UIImage imageWithContentsOfFile:path];
}
static inline UIImage *UIImageNamed(NSString *name){
    UIImage *image = [UIImage imageNamed:name];
    if (!image) { // 如果是bundle image
        image = UIImageWithBundleImageName([NSBundle mainBundle], name);
    }
    if (!image) { // 如果是path
        NSData *data = [NSData dataWithContentsOfFile:name];
        if (data) {
            image = [UIImage imageWithData:data];
        }
    }
    return image;
    
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

static inline UIImage *UIImageGetBlurredImage(UIImage *image, CGFloat ratio){
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

static inline void UIImageBlurImageAsync(UIImage *image, CGFloat ratio, void (^completion)(UIImage *image)){
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


static inline UIImage *UIImageNonInterpolatedScaleWithRatio(UIImage *image, CGFloat ratio){
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


static inline UIImage *UIImageNonInterpolatedScaleWithLength(UIImage *image, CGFloat length){
    CGRect extent = CGRectIntegral(image.CIImage.extent);
    CGFloat scale = fmin(length/CGRectGetWidth(extent), length/CGRectGetHeight(extent));
    return UIImageNonInterpolatedScaleWithRatio(image, scale);
}

static inline UIImage *UIImageNonInterpolatedScaleWithCGSize(UIImage *image, CGSize size){
    CGRect extent = CGRectIntegral(image.CIImage.extent);
    CGFloat scale = fmin(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    return UIImageNonInterpolatedScaleWithRatio(image, scale);
}


@implementation UIImage (AXAdd)

+ (UIImage * _Nonnull (^)(NSString * _Nonnull))named{
    return ^UIImage *(NSString *name){
        return UIImageNamed(name);
    };
}
+ (instancetype)imageWithView:(UIView *)view{
    return UIImageFromView(view);
}
+ (instancetype)imageWithPureColor:(UIColor *)color size:(CGSize)size{
    return UIImageGetPureColorImage(color, size);
}
+ (instancetype)imageWithNamed:(NSString *)named inBundle:(NSBundle *)bundle{
    return UIImageWithBundleImageName(bundle, named);
}


#pragma mark - 加工


- (instancetype)squared{
    return UIImageGetSquareImageAndOption(self, nil);
}

- (instancetype)rounded{
    return UIImageGetSquareImageAndOption(self, ^(CGContextRef ctx, CGRect rect) {
        CGContextAddEllipseInRect(ctx, rect);
    });
}

- (instancetype)blurred:(CGFloat)ratio{
    return UIImageGetBlurredImage(self, ratio);
}
- (void)blurred:(CGFloat)ratio completion:(void (^)(UIImage * _Nonnull))completion{
    UIImageBlurImageAsync(self, ratio, completion);
}


- (UIImage *(^)(CGFloat ratio))NonInterpolatedScaleWithRatio{
    return ^UIImage *(CGFloat ratio){
        return UIImageNonInterpolatedScaleWithRatio(self, ratio);
    };
}

- (UIImage *(^)(CGFloat ratio))NonInterpolatedScaleWithLength{
    return ^UIImage *(CGFloat length){
        return UIImageNonInterpolatedScaleWithLength(self, length);
    };
}

- (UIImage *(^)(CGSize size))NonInterpolatedScaleWithSize{
    return ^UIImage *(CGSize size){
        return UIImageNonInterpolatedScaleWithCGSize(self, size);
    };
}
@end
