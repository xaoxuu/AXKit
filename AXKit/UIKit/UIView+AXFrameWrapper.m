//
//  UIView+AXFrameWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIView+AXFrameWrapper.h"
#import "Foundation+CoreGraphics.h"

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

- (CGFloat)centerX{
    return 0.5 * self.width;
}

- (void)setCenterX:(CGFloat)centerX{
    self.left = centerX - 0.5 * self.width;
}

- (CGFloat)centerY{
    return 0.5 * self.height;
}

- (void)setCenterY:(CGFloat)centerY{
    self.top = centerY - 0.5 * self.height;
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

#pragma mark - chain

- (UIView *(^)(CGFloat))widthEqual{
    return ^(CGFloat width){
        self.width = (CGFloat)width;
        return self;
    };
}

- (UIView *(^)(CGFloat))heightEqual{
    return ^(CGFloat height){
        self.height = height;
        return self;
    };
}

- (UIView *(^)(CGFloat))widthAndHeightEqual{
    return ^(CGFloat length){
        self.width = length;
        self.height = length;
        return self;
    };
}

- (UIView *(^)(UIView *))centerEqual{
    return ^(UIView *view){
        self.centerX = view.width / 2;
        self.centerY = view.height / 2;
        self.center = view.center;
        return self;
    };
}

- (UIView *(^)(CGFloat))leftAndRightMargin{
    return ^(CGFloat margin){
        self.left = margin;
        if (self.superview) {
            self.right = self.superview.right - margin;
        } else{
            self.right = kScreenW - margin;
        }
        return self;
    };
}

- (UIView *(^)(CGFloat))topAndBottomMargin{
    return ^(CGFloat margin){
        self.top = margin;
        if (self.superview) {
            self.bottom = self.superview.bottom - margin;
        } else{
            self.bottom = kScreenH - margin;
        }
        return self;
    };
}





@end
