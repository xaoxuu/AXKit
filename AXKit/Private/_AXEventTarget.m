//
//  Foundation+AXEventTarget.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "_AXEventTarget.h"

@import ObjectiveC.runtime;

typedef NS_ENUM(NSUInteger, AXEventType) {
    AXEventTypeUnknown,
    AXEventTypeGesture,
    AXEventTypeControlEvent,
    
};
@interface AXEventTarget ()

// 委托方，谁持有target view/button
@property (strong, nonatomic) id client;

// 事件类型，用以区分是手势还是按钮
@property (assign, nonatomic) AXEventType type;

// 事件id，用以区分这个委托方委托的所有事件，可以是UIGestureRecognizer或者@(UIControlEvents)
@property (strong, nonatomic) id key;

// 事件处理函数
@property (copy, nonatomic) void (^handler)(id sender);

@end

static inline NSMutableArray<AXEventTarget *> *getTargets(NSObject *obj){
    static const void *key = &key;
    NSMutableArray<AXEventTarget *> *targets = objc_getAssociatedObject(obj, key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(obj, key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

static inline void removeTargets(NSObject *obj, AXEventType type, BOOL (^target)(AXEventTarget *target)){
    // view的执行者列表中移除执行者
    NSMutableArray<AXEventTarget *> *targets = getTargets(obj);
    // 移除这个手势的所有执行者
    for (int i = 0; i < targets.count; i++) {
        AXEventTarget *obj = targets[i];
        if (target && obj.type == type) {
            BOOL remove = target(obj);
            if (remove) {
                [targets removeObject:obj];
                i--;
            }
        }
    }
}
@implementation AXEventTarget

- (instancetype)initWithClient:(id)client type:(AXEventType)type key:(id)key handler:(void (^)(id sender))handler {
    if (self = [super init]) {
        self.client = client;
        self.type = type;
        self.key = key;
        self.handler = handler;
    }
    return self;
}

- (void)handleEvent:(id)sender{
    if (self.handler) {
        self.handler(sender);
    }
}

+ (instancetype)targetWithView:(UIView *)view gestureRecognizer:(__kindof UIGestureRecognizer *)gestureRecognizer handler:(void (^)(__kindof UIGestureRecognizer *sender))handler{
    return [[self alloc] initWithView:view gestureRecognizer:gestureRecognizer handler:handler];
}
- (instancetype)initWithView:(UIView *)view gestureRecognizer:(__kindof UIGestureRecognizer *)gestureRecognizer handler:(void (^)(__kindof UIGestureRecognizer *sender))handler{
    if (self = [self initWithClient:view type:AXEventTypeGesture key:gestureRecognizer handler:handler]) {
        // view添加手势事件响应者
        [view addGestureRecognizer:gestureRecognizer];
        [gestureRecognizer addTarget:self action:@selector(handleEvent:)];
        
        // 保存事件响应者到view
        [getTargets(view) addObject:self];
        
    }
    return self;
}
+ (void)removeAllGesturesRecognizerForView:(UIView *)view{
    removeTargets(view, AXEventTypeGesture, ^BOOL(AXEventTarget *target) {
        UIGestureRecognizer *gestureRecognizer = target.key;
        [gestureRecognizer removeTarget:target action:@selector(handleEvent:)];
        return YES;
    });
}
+ (void)removeGesturesRecognizer:(UIGestureRecognizer *)gestureRecognizer forView:(UIView *)view{
    removeTargets(view, AXEventTypeGesture, ^BOOL(AXEventTarget *target) {
        UIGestureRecognizer *key = target.key;
        if ([key isEqual:gestureRecognizer]) {
            [gestureRecognizer removeTarget:target action:@selector(handleEvent:)];
            return YES;
        } else {
            return NO;
        }
    });
}

+ (instancetype)targetWithControl:(UIControl *)control controlEvents:(UIControlEvents)controlEvents handler:(void (^)(__kindof UIControl *sender))handler{
    return [[self alloc] initWithControl:control controlEvents:controlEvents handler:handler];
}
- (instancetype)initWithControl:(UIControl *)control controlEvents:(UIControlEvents)controlEvents handler:(void (^)(__kindof UIControl *sender))handler{
    if (self = [self initWithClient:control type:AXEventTypeControlEvent key:@(controlEvents) handler:handler]) {
        // control添加事件响应者
        [control addTarget:self action:@selector(handleEvent:) forControlEvents:controlEvents];
        
        // 保存事件响应者到control
        [getTargets(control) addObject:self];
    }
    return self;
}

+ (void)removeControlEvents:(UIControlEvents)controlEvents forControl:(UIControl *)control{
    removeTargets(control, AXEventTypeControlEvent, ^BOOL(AXEventTarget *target) {
        NSNumber *key = target.key;
        if (key.integerValue & controlEvents) {
            [control removeTarget:target action:@selector(handleEvent:) forControlEvents:controlEvents];
            return YES;
        }
        return NO;
    });
}

@end
