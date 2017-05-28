//
//  UIView+AXGestureExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIView+AXGestureExtension.h"
#import "NSString+AXExtension.h"
#import "UIView+AXAnimatedWrapper.h"
#import "_AXEventTarget.h"

// create a new target
#define AXDefaultTarget AXTargetWith(self, gesture, handler)

@import ObjectiveC.runtime;

static const void *UIViewGestureAXBlockWrapperKey = &UIViewGestureAXBlockWrapperKey;

static inline void AXBindGestureAndTarget(UIGestureRecognizer *gesture, AXEventTarget *target){
    [gesture addTarget:target action:@selector(handleEvent:)];
}

static inline AXEventTarget *AXTargetWith(UIView *obj, __kindof UIGestureRecognizer *gesture, id handler){
    // create a target with <handler>
    AXEventTarget *target = [AXEventTarget targetWithHandler:handler];
    // add a <gesture> to target
    [obj addGestureRecognizer:gesture];
    // save target (gesture + handler) to dictionary
    NSMutableDictionary *gestures = objc_getAssociatedObject(obj, UIViewGestureAXBlockWrapperKey);
    if (!gestures) {
        gestures = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(obj, UIViewGestureAXBlockWrapperKey, gestures, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSMutableSet *handlers = gestures[NSStringFromPointer(gesture)];
    if (!handlers) {
        handlers = [NSMutableSet set];
        gestures[NSStringFromPointer(gesture)] = handlers;
    }
    [handlers addObject:target];
    return target;
}


@implementation UIView (ATGestureExtension)

- (void)_addGestures:(__kindof UIGestureRecognizer *(^)(AXEventTarget *target))sender handler:(void (^)(__kindof UIGestureRecognizer *sender))handler{
    // create a target with <handler>
    AXEventTarget *target = [AXEventTarget targetWithHandler:handler];
    // add a <gesture> to target
    UIGestureRecognizer *gesture = sender(target);
    
    // save target (gesture + handler) to dictionary
    NSMutableDictionary *gestures = objc_getAssociatedObject(self, UIViewGestureAXBlockWrapperKey);
    if (!gestures) {
        gestures = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, UIViewGestureAXBlockWrapperKey, gestures, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSMutableSet *handlers = gestures[NSStringFromPointer(gesture)];
    if (!handlers) {
        handlers = [NSMutableSet set];
        gestures[NSStringFromPointer(gesture)] = handlers;
    }
    [handlers addObject:target];
}

#pragma mark tap / long press

- (void)ax_addTapGestureHandler:(void (^)(UITapGestureRecognizer *sender))handler{
    if ([self isKindOfClass:[UIImageView class]]) {
        self.userInteractionEnabled = YES;
    }
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    AXBindGestureAndTarget(gesture, AXDefaultTarget);
    
}

- (void)ax_addTapGesture:(void (^)(UITapGestureRecognizer *sender))tap handler:(void (^)(UITapGestureRecognizer *sender))handler{
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    AXBindGestureAndTarget(gesture, AXDefaultTarget);
    // more setting
    if (tap) {
        tap(gesture);
    }
    
}

- (void)ax_addTapGesture:(void (^)(UITapGestureRecognizer *sender))tap handler:(void (^)(UITapGestureRecognizer *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration{
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    AXEventTarget *target = AXDefaultTarget;
    AXBindGestureAndTarget(gesture, target);
    [target setupAnimationWithView:self scale:scale duration:duration];
    // more setting
    if (tap) {
        tap(gesture);
    }
    
}


- (void)ax_addDoubleTapGesture:(void (^)(UITapGestureRecognizer *sender))doubleTap duration:(NSTimeInterval)duration handler:(void (^)(UITapGestureRecognizer *sender))handler{
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    AXBindGestureAndTarget(gesture, AXDefaultTarget);
    // more setting
    gesture.numberOfTapsRequired = 2;
    if (doubleTap) {
        doubleTap(gesture);
    }
    
}

- (void)ax_addLongPressGesture:(void (^)(UILongPressGestureRecognizer *))longPress handler:(void (^)(UILongPressGestureRecognizer *))handler{
    
    UILongPressGestureRecognizer *gesture = [UILongPressGestureRecognizer new];
    AXBindGestureAndTarget(gesture, AXDefaultTarget);
    // more setting
    gesture.minimumPressDuration = 2;
    if (longPress) {
        longPress(gesture);
    }
    
}


#pragma mark swipe / pan / screen edge pan

- (void)ax_addSwipeGesture:(void (^)(UISwipeGestureRecognizer *sender))swipe handler:(void (^)(UISwipeGestureRecognizer *sender))handler {
    
    UISwipeGestureRecognizer *gesture = [UISwipeGestureRecognizer new];
    AXBindGestureAndTarget(gesture, AXDefaultTarget);
    // more setting
    if (swipe) {
        swipe(gesture);
    }
    
}

- (void)ax_addPanGesture:(void (^)(UIPanGestureRecognizer *sender))pan handler:(void (^)(UIPanGestureRecognizer *sender))handler {
    
    UIPanGestureRecognizer *gesture = [UIPanGestureRecognizer new];
    AXBindGestureAndTarget(gesture, AXDefaultTarget);
    // more setting
    if (pan) {
        pan(gesture);
    }
    
}

- (void)ax_addScreenEdgePanGesture:(void (^)(UIScreenEdgePanGestureRecognizer *sender))screenEdgePan handler:(void (^)(UIScreenEdgePanGestureRecognizer *sender))handler {
    
    UIScreenEdgePanGestureRecognizer *gesture = [UIScreenEdgePanGestureRecognizer new];
    AXBindGestureAndTarget(gesture, AXDefaultTarget);
    // more setting
    if (screenEdgePan) {
        screenEdgePan(gesture);
    }
    
}

#pragma mark pinch / rotation

- (void)ax_addPinchGesture:(void (^)(UIPinchGestureRecognizer *sender))pinch handler:(void (^)(UIPinchGestureRecognizer *sender))handler {
    
    UIPinchGestureRecognizer *gesture = [UIPinchGestureRecognizer new];
    AXBindGestureAndTarget(gesture, AXDefaultTarget);
    // more setting
    if (pinch) {
        pinch(gesture);
    }
    
}

- (void)ax_addRotationGesture:(void (^)(UIRotationGestureRecognizer *sender))rotation handler:(void (^)(UIRotationGestureRecognizer *sender))handler {
    
    UIRotationGestureRecognizer *gesture = [UIRotationGestureRecognizer new];
    AXBindGestureAndTarget(gesture, AXDefaultTarget);
    // more setting
    if (rotation) {
        rotation(gesture);
    }
    
}


@end



