//
//  UIView+AXFrameAdd.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIView+AXFrameAdd.h"


@implementation UIView (AXFrameAdd)


- (CGPoint)boundsCenter{
    return CGPointMake(0.5*self.bounds.size.width, 0.5*self.bounds.size.height);
}

- (UIView *(^)(CGFloat width))setWidth{
    return ^UIView *(CGFloat width){
        CGRect frame = self.frame;
        frame.size.width = width;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGFloat height))setHeight{
    return ^UIView *(CGFloat height){
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGSize size))setSize{
    return ^UIView *(CGSize size){
        CGRect frame = self.frame;
        frame.size = size;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGFloat x))setX{
    return ^UIView *(CGFloat x){
        CGRect frame = self.frame;
        frame.origin.x = x;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGFloat x))setY{
    return ^UIView *(CGFloat y){
        CGRect frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGFloat centerX))setCenterX{
    return ^UIView *(CGFloat centerX){
        self.center = CGPointMake(centerX, self.center.y);
        return self;
    };
}

- (UIView *(^)(CGFloat centerY))setCenterY{
    return ^UIView *(CGFloat centerY){
        self.center = CGPointMake(self.center.x, centerY);
        return self;
    };
}

@end
