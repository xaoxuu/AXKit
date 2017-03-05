//
//  UIBarButtonItem+AXBlockWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIBarButtonItem+AXBlockWrapper.h"
@import ObjectiveC.runtime;

static const void *UIBarButtonItemATBlockWrapperKey = &UIBarButtonItemATBlockWrapperKey;

@interface UIBarButtonItem (BlocksKitPrivate)

- (void)ax_handleAction:(UIBarButtonItem *)sender;

@end

@implementation UIBarButtonItem (ATBlockWrapper)


- (void)ax_handleAction:(UIBarButtonItem *)sender
{
    void (^block)(id) = objc_getAssociatedObject(self, UIBarButtonItemATBlockWrapperKey);
    if (block) block(sender);
}

+ (instancetype)ax_itemWithSystem:(UIBarButtonSystemItem)systemItem action:(void (^)(id sender))action {
    return [[self alloc] ax_initWithSystem:systemItem action:action];
}

- (instancetype)ax_initWithSystem:(UIBarButtonSystemItem)systemItem action:(void (^)(id sender))action AX_INITIALIZER {
    self = [self initWithBarButtonSystemItem:systemItem target:self action:@selector(ax_handleAction:)];
    if (!self) return nil;
    
    objc_setAssociatedObject(self, UIBarButtonItemATBlockWrapperKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

+ (instancetype)ax_itemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action {
    return [[self alloc] ax_initWithImage:image style:style action:action];
}

- (instancetype)ax_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action AX_INITIALIZER {
    self = [self initWithImage:image style:style target:self action:@selector(ax_handleAction:)];
    if (!self) return nil;
    
    objc_setAssociatedObject(self, UIBarButtonItemATBlockWrapperKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

+ (instancetype)ax_itemWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action {
    return [[self alloc] ax_initWithImage:image landscapeImagePhone:landscapeImagePhone style:style action:action];
}

- (instancetype)ax_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action AX_INITIALIZER {
    self = [self initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:self action:@selector(ax_handleAction:)];
    if (!self) return nil;
    
    objc_setAssociatedObject(self, UIBarButtonItemATBlockWrapperKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

+ (instancetype)ax_itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action {
    return [[self alloc] ax_initWithTitle:title style:style action:action];
}

- (instancetype)ax_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action AX_INITIALIZER {
    self = [self initWithTitle:title style:style target:self action:@selector(ax_handleAction:)];
    if (!self) return nil;
    
    objc_setAssociatedObject(self, UIBarButtonItemATBlockWrapperKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}



@end
