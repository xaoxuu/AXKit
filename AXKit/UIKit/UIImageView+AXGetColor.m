//
//  UIImageView+AXGetColor.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIImageView+AXGetColor.h"



/**
 从UIImageView指定Point取色（RGBA）

 @param imageView imageview
 @param point 坐标点
 @param red red value
 @param green green value
 @param blue blue value
 @param alpha alpha value
 */
static inline void UIImageViewGetRGBAWithPoint(UIImageView *imageView, CGPoint point, CGFloat *red, CGFloat *green, CGFloat *blue, CGFloat *alpha){
    // frame of image
    const CGRect imageFrame = CGRectMake(0.0f, 0.0f,
                                         imageView.frame.size.width, imageView.frame.size.height);
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(imageFrame, point)) {
        return;
    }
    
    
    // Create RGB color space
    const CGColorSpaceRef colorSpaceRGB  = CGColorSpaceCreateDeviceRGB();
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,1,1,8,4,colorSpaceRGB,kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpaceRGB);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -point.x, point.y- imageView.frame.size.height);
    CGContextDrawImage(context, imageFrame, imageView.image.CGImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    *red   = (CGFloat)pixelData[0] / 255.0f;
    *green = (CGFloat)pixelData[1] / 255.0f;
    *blue  = (CGFloat)pixelData[2] / 255.0f;
    *alpha = (CGFloat)pixelData[3] / 255.0f;
}


/**
 从UIImageView指定Point取色（UIColor）

 @param imageView image view
 @param point 坐标点
 @return UIColor
 */
static inline UIColor *UIImageViewGetColorWithPoint(UIImageView *imageView, CGPoint point){
    // frame of image
    const CGRect imageFrame = CGRectMake(0.0f, 0.0f,
                                         imageView.frame.size.width, imageView.frame.size.height);
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(imageFrame, point)) {
        return nil;
    }
    
    // get color with point
    CGFloat red,green,blue,alpha;
    UIImageViewGetRGBAWithPoint(imageView, point, &red, &green, &blue, &alpha);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];

}


static inline void UIImageViewGetRGBA(UIImageView *imageView, CGPoint point, void(^completion)(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha)){
    if (completion) {
        CGFloat red,green,blue,alpha;
        UIImageViewGetRGBAWithPoint(imageView, point, &red, &green, &blue, &alpha);
        completion(red,green,blue,alpha);
    }
}

static inline void UIImageViewGetColor(UIImageView *imageView, CGPoint point, void(^completion)(UIColor *color)){
    if (completion) {
        UIColor *color = UIImageViewGetColorWithPoint(imageView, point);
        if (color) {
            completion(color);
        }
    }
}


static inline void UIImageViewGetRGBAFromCircle(UIImageView *imageView, CGPoint point, void(^completion)(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha)){
    // @xaoxuu: 过滤不符合条件的坐标点
    CGFloat inset = imageView.layer.borderWidth + imageView.layer.shadowRadius + 1;
    CGFloat r = 0.5 * (imageView.frame.size.width - inset);
    CGFloat x = point.x - r - 0.75*inset;
    CGFloat y = point.y - r - 0.75*inset;
    
    if (powf(x,2) + powf(y, 2) < powf(r, 2)) {
        UIImageViewGetRGBA(imageView, point, completion);
    }
}

static inline void UIImageViewGetColorFromCircle(UIImageView *imageView, CGPoint point, void(^completion)(UIColor *color)){
    // @xaoxuu: 过滤不符合条件的坐标点
    CGFloat inset = imageView.layer.borderWidth + imageView.layer.shadowRadius + 1;
    CGFloat r = 0.5 * (imageView.frame.size.width - inset);
    CGFloat x = point.x - r - 0.75*inset;
    CGFloat y = point.y - r - 0.75*inset;
    
    if (powf(x,2) + powf(y, 2) < powf(r, 2)) {
        UIImageViewGetColor(imageView, point, completion);
    }
}



@implementation UIImageView (AXGetColor)


#pragma mark - 从指定CGPoint获取UIColor

#pragma mark 推荐用于圆形取色板
// get color from circle with point and completion
- (void)ax_getColorFromCircleWithPoint:(CGPoint)point completion:(void(^)(UIColor *color))completion {
    UIImageViewGetColorFromCircle(self, point, completion);
}
// get red green blue alpha from circle with point and completion
- (void)ax_getRGBAFromCircleWithPoint:(CGPoint)point completion:(void(^)(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha))completion {
    UIImageViewGetRGBAFromCircle(self, point, completion);
}
#pragma mark 推荐用于方形取色板
// get color with point and completion
- (void)ax_getColorWithPoint:(CGPoint)point completion:(void(^)(UIColor *color))completion {
    UIImageViewGetColor(self, point, completion);
}
// get red green blue alpha with point and completion
- (void)ax_getRGBAWithPoint:(CGPoint)point completion:(void(^)(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha))completion {
    UIImageViewGetRGBA(self, point, completion);
}

#pragma mark 返回值可空，操作繁琐，不推荐用

// get color with point
- (UIColor *)ax_getColorWithPoint:(CGPoint)point{
    return UIImageViewGetColorWithPoint(self, point);
}
- (UIColor * _Nonnull (^)(CGPoint))colorInPoint{
    return ^UIColor *(CGPoint point){
        return UIImageViewGetColorWithPoint(self, point);
    };
}

// get red green blue alpha with point
- (void)ax_getRed:(nullable CGFloat *)red green:(nullable CGFloat *)green blue:(nullable CGFloat *)blue alpha:(nullable CGFloat *)alpha withPoint:(CGPoint)point{
    UIImageViewGetRGBAWithPoint(self, point, red, green, blue, alpha);
}





@end

