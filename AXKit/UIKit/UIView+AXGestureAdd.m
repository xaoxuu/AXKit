//
//  UIView+AXGestureAdd.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIView+AXGestureAdd.h"
#import "_AXEventTarget.h"

/**
 绑定手势

 @param view 视图
 @param gesture 手势
 @param handler 处理
 @return 响应者
 */
static inline AXEventTarget *bindGesture(UIView *view, UIGestureRecognizer *gesture, void (^handler)(__kindof UIGestureRecognizer *)){
    return [AXEventTarget targetWithView:view gestureRecognizer:gesture handler:handler];
}

@import ObjectiveC.runtime;


@implementation UIView (ATGestureExtension)


#pragma mark tap / long press

- (UITapGestureRecognizer *)ax_addTapGestureHandler:(void (^)(UITapGestureRecognizer *sender))handler{
    if ([self isKindOfClass:[UIImageView class]]) {
        self.userInteractionEnabled = YES;
    }
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    bindGesture(self, gesture, handler);
    return gesture;
}

- (UITapGestureRecognizer *)ax_addTapGesture:(void (^)(UITapGestureRecognizer *sender))tap handler:(void (^)(UITapGestureRecognizer *sender))handler{
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    bindGesture(self, gesture, handler);
    // more setting
    if (tap) {
        tap(gesture);
    }
    return gesture;
}

- (UITapGestureRecognizer *)ax_addDoubleTapGesture:(void (^)(UITapGestureRecognizer *sender))doubleTap duration:(NSTimeInterval)duration handler:(void (^)(UITapGestureRecognizer *sender))handler{
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    bindGesture(self, gesture, handler);
    // more setting
    gesture.numberOfTapsRequired = 2;
    if (doubleTap) {
        doubleTap(gesture);
    }
    return gesture;
}

- (UILongPressGestureRecognizer *)ax_addLongPressGesture:(void (^)(UILongPressGestureRecognizer *))longPress handler:(void (^)(UILongPressGestureRecognizer *))handler{
    
    UILongPressGestureRecognizer *gesture = [UILongPressGestureRecognizer new];
    bindGesture(self, gesture, handler);
    // more setting
    gesture.minimumPressDuration = 2;
    if (longPress) {
        longPress(gesture);
    }
    return gesture;
}


#pragma mark swipe / pan / screen edge pan

- (UISwipeGestureRecognizer *)ax_addSwipeGesture:(void (^)(UISwipeGestureRecognizer *sender))swipe handler:(void (^)(UISwipeGestureRecognizer *sender))handler {
    
    UISwipeGestureRecognizer *gesture = [UISwipeGestureRecognizer new];
    bindGesture(self, gesture, handler);
    // more setting
    if (swipe) {
        swipe(gesture);
    }
    return gesture;
}

- (UIPanGestureRecognizer *)ax_addPanGesture:(void (^)(UIPanGestureRecognizer *sender))pan handler:(void (^)(UIPanGestureRecognizer *sender))handler {
    
    UIPanGestureRecognizer *gesture = [UIPanGestureRecognizer new];
    bindGesture(self, gesture, handler);
    // more setting
    if (pan) {
        pan(gesture);
    }
    return gesture;
}

- (UIScreenEdgePanGestureRecognizer *)ax_addScreenEdgePanGesture:(void (^)(UIScreenEdgePanGestureRecognizer *sender))screenEdgePan handler:(void (^)(UIScreenEdgePanGestureRecognizer *sender))handler {
    
    UIScreenEdgePanGestureRecognizer *gesture = [UIScreenEdgePanGestureRecognizer new];
    bindGesture(self, gesture, handler);
    // more setting
    if (screenEdgePan) {
        screenEdgePan(gesture);
    }
    return gesture;
}

#pragma mark pinch / rotation

- (UIPinchGestureRecognizer *)ax_addPinchGesture:(void (^)(UIPinchGestureRecognizer *sender))pinch handler:(void (^)(UIPinchGestureRecognizer *sender))handler {
    
    UIPinchGestureRecognizer *gesture = [UIPinchGestureRecognizer new];
    bindGesture(self, gesture, handler);
    // more setting
    if (pinch) {
        pinch(gesture);
    }
    return gesture;
}

- (UIRotationGestureRecognizer *)ax_addRotationGesture:(void (^)(UIRotationGestureRecognizer *sender))rotation handler:(void (^)(UIRotationGestureRecognizer *sender))handler {
    
    UIRotationGestureRecognizer *gesture = [UIRotationGestureRecognizer new];
    bindGesture(self, gesture, handler);
    // more setting
    if (rotation) {
        rotation(gesture);
    }
    
    return gesture;
}

// MARK: remove

- (void)ax_removeGestureRecognizer:(__kindof UIGestureRecognizer *)gestureRecognizer{
    [AXEventTarget removeGesturesRecognizer:gestureRecognizer forView:self];
}
- (void)ax_removeAllGestureRecognizers{
    [AXEventTarget removeAllGesturesRecognizerForView:self];
}


@end



