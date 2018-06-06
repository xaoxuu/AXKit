//
//  Foundation+AXEventTarget.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface AXEventTarget : NSObject

/**
 视图手势的事件响应

 @param view 视图
 @param gestureRecognizer 手势
 @param handler 处理事件
 @return 响应者
 */
+ (instancetype)targetWithView:(UIView *)view gestureRecognizer:(__kindof UIGestureRecognizer *)gestureRecognizer handler:(void (^)(__kindof UIGestureRecognizer *sender))handler;

/**
 控件事件响应

 @param control 控件
 @param controlEvents 事件
 @param handler 处理事件
 @return 响应者
 */
+ (instancetype)targetWithControl:(UIControl *)control controlEvents:(UIControlEvents)controlEvents handler:(void (^)(__kindof UIControl *sender))handler;


/**
 移除某个视图的某个手势

 @param gestureRecognizer 手势
 @param view 视图
 */
+ (void)removeGesturesRecognizer:(UIGestureRecognizer *)gestureRecognizer forView:(UIView *)view;

/**
 移除某个视图的所有手势

 @param view 视图
 */
+ (void)removeAllGesturesRecognizerForView:(UIView *)view;

/**
 移除某个控件的某个事件响应

 @param controlEvents 事件
 @param control 控件
 */
+ (void)removeControlEvents:(UIControlEvents)controlEvents forControl:(UIControl *)control;


@end

NS_ASSUME_NONNULL_END
