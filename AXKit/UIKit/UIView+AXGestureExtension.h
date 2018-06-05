//
//  UIView+AXGestureExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AXGestureExtension)

/**
 处理tap手势

 @param handler 处理手势的block
 */
- (UITapGestureRecognizer *)ax_addTapGestureHandler:(void (^)(UITapGestureRecognizer *sender))handler;

/**
 添加一个tap手势，并处理

 @param tap     tap
 @param handler 处理手势的block
 */
- (UITapGestureRecognizer *)ax_addTapGesture:(nullable void (^)(UITapGestureRecognizer *sender))tap handler:(void (^)(UITapGestureRecognizer *sender))handler;

/**
 添加一个双击手势，并处理

 @param doubleTap double tap
 @param duration  双击间隔时间
 @param handler   处理手势的block
 */
- (UITapGestureRecognizer *)ax_addDoubleTapGesture:(nullable void (^)(UITapGestureRecognizer *sender))doubleTap duration:(NSTimeInterval)duration handler:(void (^)(UITapGestureRecognizer *sender))handler;

/**
 添加一个长按手势，并处理

 @param longPress 长按手势
 @param handler   处理手势的block
 */
- (UILongPressGestureRecognizer *)ax_addLongPressGesture:(nullable void (^)(UILongPressGestureRecognizer *sender))longPress handler:(void (^)(UILongPressGestureRecognizer *sender))handler;

/**
 添加一个轻扫手势，并处理

 @param swipe   轻扫
 @param handler 处理手势的block
 */
- (UISwipeGestureRecognizer *)ax_addSwipeGesture:(nullable void (^)(UISwipeGestureRecognizer *sender))swipe handler:(void (^)(UISwipeGestureRecognizer *sender))handler;

/**
 添加一个滑动手势，并处理
 
 @param pan     滑动
 @param handler 处理手势的block
 */
- (UIPanGestureRecognizer *)ax_addPanGesture:(nullable void (^)(UIPanGestureRecognizer *sender))pan handler:(void (^)(UIPanGestureRecognizer *sender))handler;

/**
 添加一个屏幕边缘滑动手势，并处理
 
 @param screenEdgePan  屏幕边缘滑动
 @param handler        处理手势的block
 */
- (UIScreenEdgePanGestureRecognizer *)ax_addScreenEdgePanGesture:(nullable void (^)(UIScreenEdgePanGestureRecognizer *sender))screenEdgePan handler:(void (^)(UIScreenEdgePanGestureRecognizer *sender))handler;

/**
 添加一个双指缩放手势，并处理

 @param pinch   双指缩放手势
 @param handler 处理手势的block
 
 sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
 sender.scale = 1;
 */
- (UIPinchGestureRecognizer *)ax_addPinchGesture:(nullable void (^)(UIPinchGestureRecognizer *sender))pinch handler:(void (^)(UIPinchGestureRecognizer *sender))handler;

/**
 添加一个双指旋转手势，并处理

 @param rotation 双指旋转手势
 @param handler  处理手势的block
 
 sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
 sender.rotation = 0;
 */
- (UIRotationGestureRecognizer *)ax_addRotationGesture:(nullable void (^)(UIRotationGestureRecognizer *sender))rotation handler:(void (^)(UIRotationGestureRecognizer *sender))handler;

/**
 移除一个手势

 @param gesture 手势对象
 */
- (void)ax_removeGesture:(__kindof UIGestureRecognizer *)gesture;

/**
 移除所有手势
 */
- (void)ax_removeAllGesture;

@end

NS_ASSUME_NONNULL_END
