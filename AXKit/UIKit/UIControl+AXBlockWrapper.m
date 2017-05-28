//
//  UIControl+AXBlockWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIControl+AXBlockWrapper.h"
#import "_AXEventTarget.h"

#define AXDefaultTargetFor(UIControlEvents) AXTargetWith(self, UIControlEvents ,handler)

@import ObjectiveC.runtime;

static const void *UIControlAXBlockWrapperKey = &UIControlAXBlockWrapperKey;

#pragma mark Category

static inline AXEventTarget *AXTargetWith(__kindof UIControl *obj, UIControlEvents controlEvents, id handler){
    
    // create a target with <handler>
    AXEventTarget *target = [AXEventTarget targetWithHandler:handler];
    // add a event to target
    [obj addTarget:target action:@selector(handleEvent:) forControlEvents:controlEvents];
    
    // save target (controlEvents + handler) to dictionary
    NSMutableDictionary *events = objc_getAssociatedObject(obj, UIControlAXBlockWrapperKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(obj, UIControlAXBlockWrapperKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    if (!handlers) {
        handlers = [NSMutableSet set];
        events[key] = handlers;
    }
    [handlers addObject:target];
    
    return target;
}

@implementation UIControl (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UIControl *sender))handler forControlEvents:(UIControlEvents)controlEvents{
    // add a control events to target
    AXDefaultTargetFor(controlEvents);
}

- (void)ax_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents{
    // get events
    NSMutableDictionary *events = objc_getAssociatedObject(self, UIControlAXBlockWrapperKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, UIControlAXBlockWrapperKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // get handlers from events
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    // remove handler
    if (handlers){
        [handlers enumerateObjectsUsingBlock:^(id target, BOOL *stop) {
            [self removeTarget:target action:NULL forControlEvents:controlEvents];
        }];
        [events removeObjectForKey:key];
    }
    
}

- (NSUInteger)ax_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents{
    // get events
    NSMutableDictionary *events = objc_getAssociatedObject(self, UIControlAXBlockWrapperKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, UIControlAXBlockWrapperKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // get handlers from events
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    
    return handlers.count;
    
}

@end


#pragma mark - UIButton

@implementation UIButton (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UIButton *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    AXDefaultTargetFor(controlEvents);
}

- (void)ax_addTouchDownHandler:(void (^)(__kindof UIButton *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventTouchDown);
}

- (void)ax_addTouchUpInsideHandler:(void (^)(__kindof UIButton *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventTouchUpInside);
}

- (void)ax_addTouchUpInsideHandler:(void (^)(__kindof UIButton *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration{
    // add a control events to target
    AXEventTarget *target = AXDefaultTargetFor(UIControlEventTouchUpInside);
    [target setupAnimationWithView:self scale:scale duration:duration];
}


@end

#pragma mark - UISlider

@implementation UISlider (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UISlider *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    AXDefaultTargetFor(controlEvents);
}

- (void)ax_addTouchDownHandler:(void (^)(__kindof UISlider *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventTouchDown);
}

- (void)ax_addTouchDownHandler:(void (^)(__kindof UISlider *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration{
    // add a control events to target
    AXEventTarget *target = AXDefaultTargetFor(UIControlEventTouchDown);
    [target setupAnimationWithView:self scale:scale duration:duration];
}

- (void)ax_addValueChangedHandler:(void (^)(__kindof UISlider *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventValueChanged);
}

- (void)ax_addTouchUpHandler:(void (^)(__kindof UISlider *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventTouchUpInside);
    AXDefaultTargetFor(UIControlEventTouchUpOutside);
}

- (void)ax_addTouchUpHandler:(void (^)(__kindof UISlider *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration{
    // add a control events to target
    AXEventTarget *target = AXDefaultTargetFor(UIControlEventTouchUpInside);
    [target setupAnimationWithView:self scale:scale duration:duration];
    target = AXDefaultTargetFor(UIControlEventTouchUpOutside);
    [target setupAnimationWithView:self scale:scale duration:duration];
}

@end


#pragma mark - UISwitch

@implementation UISwitch (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UISwitch *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    AXDefaultTargetFor(controlEvents);
}

- (void)ax_addTouchDownHandler:(void (^)(__kindof UISwitch *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventTouchDown);
}

- (void)ax_addValueChangedHandler:(void (^)(__kindof UISwitch *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventValueChanged);
}

- (void)ax_addTouchUpInsideHandler:(void (^)(__kindof UISwitch *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventTouchUpInside);
}

@end


#pragma mark - UISegmentedControl

@implementation UISegmentedControl (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UISegmentedControl *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    AXDefaultTargetFor(controlEvents);
}

- (void)ax_addValueChangedHandler:(void (^)(__kindof UISegmentedControl *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventValueChanged);
}

@end


#pragma mark - UITextField

@implementation UITextField (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UITextField *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    AXDefaultTargetFor(controlEvents);
}

- (void)ax_addEditingBeginHandler:(void (^)(__kindof UITextField *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventEditingDidBegin);
}

- (void)ax_addEditingBeginHandler:(void (^)(__kindof UITextField *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration{
    // add a control events to target
    AXEventTarget *target = AXDefaultTargetFor(UIControlEventEditingDidBegin);
    [target setupAnimationWithView:self scale:scale duration:duration];
}

- (void)ax_addEditingChangedHandler:(void (^)(__kindof UITextField *sender))handler{
    // add a control events to target
    AXDefaultTargetFor(UIControlEventEditingChanged);
}

- (void)ax_addEditingEndOnExitHandler:(void (^)(__kindof UITextField *sender))handler{
    // resign first responder
    [self resignFirstResponder];
    // add a control events to target
    AXDefaultTargetFor(UIControlEventEditingDidEndOnExit);
}

- (void)ax_addEditingEndHandler:(void (^)(__kindof UITextField *sender))handler{
    // resign first responder
    [self ax_addEditingEndOnExitHandler:^(__kindof UITextField * _Nonnull sender) {
        // do nothing
    }];
    // add a control events to target
    AXDefaultTargetFor(UIControlEventEditingDidEnd);
}

- (void)ax_addEditingEndHandler:(void (^)(__kindof UITextField *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration{
    // resign first responder
    [self ax_addEditingEndOnExitHandler:^(__kindof UITextField * _Nonnull sender) {
        // do nothing
    }];
    // add a control events to target
    AXEventTarget *target =  AXDefaultTargetFor(UIControlEventEditingDidEnd);
    [target setupAnimationWithView:self scale:scale duration:duration];
}

@end




