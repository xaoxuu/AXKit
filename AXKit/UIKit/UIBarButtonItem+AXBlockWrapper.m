//
//  UIBarButtonItem+AXBlockWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIBarButtonItem+AXBlockWrapper.h"
#import "UIView+AXGestureExtension.h"

@import ObjectiveC.runtime;

static const void *UIBarButtonItemAXBlockWrapperKey = &UIBarButtonItemAXBlockWrapperKey;

@implementation UIBarButtonItem (AXBlockWrapper)

#pragma mark - 静态构造方法

#pragma mark 推荐

+ (instancetype)ax_itemWithImageName:(NSString *)image action:(void (^)(UIBarButtonItem *sender))action{
    return [self ax_itemWithImage:[UIImage imageNamed:image] style:UIBarButtonItemStylePlain action:action];
}

+ (instancetype)ax_itemWithTitle:(NSString *)title action:(void (^)(UIBarButtonItem *sender))action{
    return [self ax_itemWithTitle:title style:UIBarButtonItemStylePlain action:action];
}

+ (instancetype)ax_itemWithCustomView:(UIView *)view action:(void (^)(UIBarButtonItem *sender))action{
    return [[self alloc] ax_initWithCustomView:view action:action];
}


#pragma mark 普通

+ (instancetype)ax_itemWithSystem:(UIBarButtonSystemItem)systemItem action:(void (^)(UIBarButtonItem *sender))action {
    return [[self alloc] ax_initWithSystemItem:systemItem action:action];
}

+ (instancetype)ax_itemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action {
    return [[self alloc] ax_initWithImage:image style:style action:action];
}

+ (instancetype)ax_itemWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action {
    return [[self alloc] ax_initWithImage:image landscapeImagePhone:landscapeImagePhone style:style action:action];
}

+ (instancetype)ax_itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action {
    return [[self alloc] ax_initWithTitle:title style:style action:action];
}


#pragma mark - 实例构造方法

- (instancetype)ax_initWithSystemItem:(UIBarButtonSystemItem)systemItem action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER {
    if (self = [self initWithBarButtonSystemItem:systemItem target:self action:@selector(ax_handleAction:)]) {
        objc_setAssociatedObject(self, UIBarButtonItemAXBlockWrapperKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return self;
}

- (instancetype)ax_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER {
    if (self = [self initWithImage:image style:style target:self action:@selector(ax_handleAction:)]) {
        objc_setAssociatedObject(self, UIBarButtonItemAXBlockWrapperKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return self;
}

- (instancetype)ax_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER {
    if (self = [self initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:self action:@selector(ax_handleAction:)]) {
        objc_setAssociatedObject(self, UIBarButtonItemAXBlockWrapperKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return self;
}

- (instancetype)ax_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER {
    if (self = [self initWithTitle:title style:style target:self action:@selector(ax_handleAction:)]) {
        objc_setAssociatedObject(self, UIBarButtonItemAXBlockWrapperKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return self;
}

- (instancetype)ax_initWithCustomView:(UIView *)view action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER{
    if (self = [self initWithCustomView:view]) {
        if (action) {
            typeof(self) weakSelf = self;
            [view ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
                action(weakSelf);
            }];
        }
    }
    return self;
}

// MARK: priv

- (void)ax_handleAction:(UIBarButtonItem *)sender {
    void (^block)(id) = objc_getAssociatedObject(self, UIBarButtonItemAXBlockWrapperKey);
    !block?:block(sender);
}


@end
