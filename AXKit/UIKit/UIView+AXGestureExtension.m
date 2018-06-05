//
//  UIView+AXGestureExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIView+AXGestureExtension.h"
#import "UIView+AXAnimatedWrapper.h"
#import "_AXEventTarget.h"

@import ObjectiveC.runtime;

static const void *UIViewGestureAXBlockWrapperKey = &UIViewGestureAXBlockWrapperKey;

static inline NSString *keyForGesture(id x){
    return [NSString stringWithFormat:@"%p",x];
}

static inline NSMutableDictionary *AXGetGestures(UIView *obj){
    NSMutableDictionary *gestures = objc_getAssociatedObject(obj, UIViewGestureAXBlockWrapperKey);
    if (!gestures) {
        gestures = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(obj, UIViewGestureAXBlockWrapperKey, gestures, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gestures;
}

// 把手势和执行体绑定并保存为view的私有属性
static inline AXEventTarget *AXTargetWith(UIView *view, __kindof UIGestureRecognizer *gesture, id handler){
    // view添加手势
    [view addGestureRecognizer:gesture];
    
    // 获取view的手势执行者列表
    NSMutableDictionary *gestures = AXGetGestures(view);
    NSMutableSet *targets = gestures[keyForGesture(gesture)];
    if (!targets) {
        targets = [NSMutableSet set];
        gestures[keyForGesture(gesture)] = targets;
    }
    
    // 创建事件执行者
    AXEventTarget *target = [AXEventTarget targetWithHandler:handler];
    // 保存事件执行者到view的列表
    [targets addObject:target];
    return target;
}

static inline void removeGesture(UIView *view, __kindof UIGestureRecognizer *gesture){
    // view移除手势
    [view removeGestureRecognizer:gesture];
    // view的执行者列表中移除执行者
    NSMutableDictionary *gestures = AXGetGestures(view);
    // 移除这个手势的所有执行者
    [gestures removeObjectForKey:keyForGesture(gesture)];
}

@implementation UIView (ATGestureExtension)


#pragma mark tap / long press

- (UITapGestureRecognizer *)ax_addTapGestureHandler:(void (^)(UITapGestureRecognizer *sender))handler{
    if ([self isKindOfClass:[UIImageView class]]) {
        self.userInteractionEnabled = YES;
    }
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
    return gesture;
}

- (UITapGestureRecognizer *)ax_addTapGesture:(void (^)(UITapGestureRecognizer *sender))tap handler:(void (^)(UITapGestureRecognizer *sender))handler{
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
    // more setting
    if (tap) {
        tap(gesture);
    }
    return gesture;
}

- (UITapGestureRecognizer *)ax_addTapGesture:(void (^)(UITapGestureRecognizer *sender))tap handler:(void (^)(UITapGestureRecognizer *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration{
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    AXEventTarget *target = AXTargetWith(self, gesture, handler);
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
    [target setupAnimationWithView:self scale:scale duration:duration];
    // more setting
    if (tap) {
        tap(gesture);
    }
    return gesture;
}


- (UITapGestureRecognizer *)ax_addDoubleTapGesture:(void (^)(UITapGestureRecognizer *sender))doubleTap duration:(NSTimeInterval)duration handler:(void (^)(UITapGestureRecognizer *sender))handler{
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
    // more setting
    gesture.numberOfTapsRequired = 2;
    if (doubleTap) {
        doubleTap(gesture);
    }
    return gesture;
}

- (UILongPressGestureRecognizer *)ax_addLongPressGesture:(void (^)(UILongPressGestureRecognizer *))longPress handler:(void (^)(UILongPressGestureRecognizer *))handler{
    
    UILongPressGestureRecognizer *gesture = [UILongPressGestureRecognizer new];
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
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
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
    // more setting
    if (swipe) {
        swipe(gesture);
    }
    return gesture;
}

- (UIPanGestureRecognizer *)ax_addPanGesture:(void (^)(UIPanGestureRecognizer *sender))pan handler:(void (^)(UIPanGestureRecognizer *sender))handler {
    
    UIPanGestureRecognizer *gesture = [UIPanGestureRecognizer new];
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
    // more setting
    if (pan) {
        pan(gesture);
    }
    return gesture;
}

- (UIScreenEdgePanGestureRecognizer *)ax_addScreenEdgePanGesture:(void (^)(UIScreenEdgePanGestureRecognizer *sender))screenEdgePan handler:(void (^)(UIScreenEdgePanGestureRecognizer *sender))handler {
    
    UIScreenEdgePanGestureRecognizer *gesture = [UIScreenEdgePanGestureRecognizer new];
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
    // more setting
    if (screenEdgePan) {
        screenEdgePan(gesture);
    }
    return gesture;
}

#pragma mark pinch / rotation

- (UIPinchGestureRecognizer *)ax_addPinchGesture:(void (^)(UIPinchGestureRecognizer *sender))pinch handler:(void (^)(UIPinchGestureRecognizer *sender))handler {
    
    UIPinchGestureRecognizer *gesture = [UIPinchGestureRecognizer new];
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
    // more setting
    if (pinch) {
        pinch(gesture);
    }
    return gesture;
}

- (UIRotationGestureRecognizer *)ax_addRotationGesture:(void (^)(UIRotationGestureRecognizer *sender))rotation handler:(void (^)(UIRotationGestureRecognizer *sender))handler {
    
    UIRotationGestureRecognizer *gesture = [UIRotationGestureRecognizer new];
    [gesture addTarget:AXTargetWith(self, gesture, handler) action:@selector(handleEvent:)];
    // more setting
    if (rotation) {
        rotation(gesture);
    }
    return gesture;
}

// MARK: remove

- (void)ax_removeGesture:(__kindof UIGestureRecognizer *)gesture{
    removeGesture(self, gesture);
}


@end



