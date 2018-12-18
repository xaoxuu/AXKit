//
//  UIView+AXFrameAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (AXFrameAdd)


/**
 获取容器的中心坐标

 @return 容器的中心坐标
 */
- (CGPoint)boundsCenter;

/**
 设置view的宽
 */
- (UIView *(^)(CGFloat width))setWidth;

/**
 设置view的高
 */
- (UIView *(^)(CGFloat height))setHeight;

/**
 设置view的size
 */
- (UIView *(^)(CGSize size))setSize;

/**
 设置view的x坐标
 */
- (UIView *(^)(CGFloat x))setX;

/**
 设置view的y坐标
 */
- (UIView *(^)(CGFloat x))setY;

/**
 设置view的横坐标中心
 */
- (UIView *(^)(CGFloat centerX))setCenterX;

/**
 设置view的横坐标中心
 */
- (UIView *(^)(CGFloat centerY))setCenterY;

@end
