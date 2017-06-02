//
//  UIView+AXFrameWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIView+AXFrameWrapper.h"
#import "CoreGraphics+AXExtension.h"



@implementation UIView (AXFrameWrapper)

#pragma mark - property

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setRight:(CGFloat)right{
    self.left = right - self.width;
}

- (void)setBottom:(CGFloat)bottom{
    self.top = bottom - self.height;
}

#pragma mark frame center

- (CGPoint)frameCenter{
    return self.center;
}
- (void)setFrameCenter:(CGPoint)frameCenter{
    self.center = frameCenter;
}

- (CGFloat)frameCenterX{
    return self.center.x;
}
- (void)setFrameCenterX:(CGFloat)frameCenterX{
    CGPoint center = self.center;
    center.x = frameCenterX;
    self.center = center;
}

- (CGFloat)frameCenterY{
    return self.center.y;
}
- (void)setFrameCenterY:(CGFloat)frameCenterY{
    CGPoint center = self.center;
    center.y = frameCenterY;
    self.center = center;
}

#pragma mark bounds center

- (CGPoint)boundsCenter{
    return CGPointMake(self.boundsCenterX, self.boundsCenterY);
}
- (CGFloat)boundsCenterX{
    return 0.5*self.bounds.size.width;
}
- (CGFloat)boundsCenterY{
    return 0.5*self.bounds.size.height;
}




@end
