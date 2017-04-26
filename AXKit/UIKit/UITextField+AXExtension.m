//
//  UITextField+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UITextField+AXExtension.h"
@import ObjectiveC.runtime;

static const void *UITextFieldAXExtensionKey_ContentEdgeInsets = &UITextFieldAXExtensionKey_ContentEdgeInsets;
static const void *UITextFieldAXExtensionKey_SuperView = &UITextFieldAXExtensionKey_SuperView;

@interface UITextField ()

// super view
@property (strong, nonatomic) UIView *ax_superview;
// content edge inset
@property (assign, nonatomic) UIEdgeInsets contentEdgeInsets;

@end



@implementation UITextField (AXExtension)


- (void)ax_clearText {
    self.text = @"";
}

- (void)ax_adjustViewFrameWithKeyboard:(UIView *)view {
    self.ax_superview = view;
    // 添加对键盘的监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// 弹出键盘
- (void)_keyBoardWillShow:(NSNotification *) note {
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // @xaoxuu: 获取view距离底部的高度
    CGFloat superH = self.ax_superview.frame.size.height;
    CGFloat superF = self.ax_superview.frame.origin.y;
    CGFloat heightToBottom = kScreenH - superF - superH;
    // @xaoxuu: 被遮挡的高度
    CGFloat offset = keyBoardHeight - heightToBottom;
    if (offset < 0) {
        offset = 0;
    }
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.ax_superview.transform = CGAffineTransformMakeTranslation(0, - offset);
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
    
}


// 隐藏键盘
- (void)_keyBoardWillHide:(NSNotification *) note {
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.ax_superview.transform = CGAffineTransformIdentity;
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

#pragma mark - private methods
/*
 + (void)load{
 
 // exchange (textRectForBounds)
 Method textRectForBounds = class_getInstanceMethod([UITextField class], @selector(textRectForBounds:));
 Method ax_textRectForBounds = class_getInstanceMethod([UITextField class], @selector(ax_textRectForBounds:));
 method_exchangeImplementations(textRectForBounds, ax_textRectForBounds);
 // exchage (editingRectForBounds)
 Method editingRectForBounds = class_getInstanceMethod([UITextField class], @selector(editingRectForBounds:));
 Method ax_editingRectForBounds = class_getInstanceMethod([UITextField class], @selector(ax_editingRectForBounds:));
 method_exchangeImplementations(editingRectForBounds, ax_editingRectForBounds);
 
 }
 */

- (UIEdgeInsets)contentEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, UITextFieldAXExtensionKey_ContentEdgeInsets);
    return [value UIEdgeInsetsValue];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets{
    NSValue *value = [NSValue valueWithUIEdgeInsets:contentEdgeInsets];
    objc_setAssociatedObject(self, UITextFieldAXExtensionKey_ContentEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)ax_superview{
    return objc_getAssociatedObject(self, UITextFieldAXExtensionKey_SuperView);
}

- (void)setAx_superview:(UIView *)ax_superview{
    objc_setAssociatedObject(self, UITextFieldAXExtensionKey_SuperView, ax_superview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 控制文本所在的的位置
- (CGRect)ax_textRectForBounds:(CGRect)bounds{
    UIEdgeInsets inset = self.contentEdgeInsets;
    return CGRectMake(inset.left, inset.top, bounds.size.width - inset.left - inset.right, bounds.size.height - inset.top - inset.bottom);
}

// 控制编辑文本时所在的位置
- (CGRect)ax_editingRectForBounds:(CGRect)bounds{
    UIEdgeInsets inset = self.contentEdgeInsets;
    return CGRectMake(inset.left, inset.top, bounds.size.width - inset.left - inset.right, bounds.size.height - inset.top - inset.bottom);
}



@end

