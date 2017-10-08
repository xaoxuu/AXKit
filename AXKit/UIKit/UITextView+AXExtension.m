//
//  UITextView+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UITextView+AXExtension.h"
#import "UIView+AXExtension.h"

@import ObjectiveC.runtime;

static const void *UITextViewAXExtensionKey_SuperView = &UITextViewAXExtensionKey_SuperView;

@interface UITextView ()

// super view
@property (strong, nonatomic) UIView *ax_superview;


@end



@implementation UITextView (AXExtension)


- (void)ax_adjustViewFrameWithKeyboard:(UIView *)view {
    self.ax_superview = view;
    // 添加对键盘的监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

// 弹出键盘
- (void)_keyBoardWillShow:(NSNotification *)note {
    if (!self.isFirstResponder) {
        return;
    }
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // @xaoxuu: 获取view距离底部的高度
    CGFloat heightToBottom = kScreenH - self.frameInScreen.origin.y - self.frameInScreen.size.height;
    // @xaoxuu: 被遮挡的高度
    CGFloat offset = keyBoardHeight - heightToBottom;
    if (offset < 0) {
        return;
    }
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^{
        self.ax_superview.transform = CGAffineTransformMakeTranslation(0, - offset);
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
    
}

// 隐藏键盘
- (void)_keyBoardWillHide:(NSNotification *)note {
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^{
        self.ax_superview.transform = CGAffineTransformIdentity;
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

- (CGFloat)ax_heightWithText:(NSString *)text heightRange:(AXFloatRange)range{
    CGSize constraint = CGSizeMake(self.contentSize.width , CGFLOAT_MAX);
    CGRect size = [text boundingRectWithSize:constraint
                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                     context:nil];
    CGFloat textHeight = size.size.height + range.minValue;
    if (textHeight > range.maxValue) {
        textHeight = range.maxValue;
        [self scrollRectToVisible:CGRectMake(0, textHeight, 0, 0) animated:YES];
    }
    return textHeight;
}


#pragma mark - private methods

- (UIView *)ax_superview{
    return objc_getAssociatedObject(self, UITextViewAXExtensionKey_SuperView);
}

- (void)setAx_superview:(UIView *)ax_superview{
    objc_setAssociatedObject(self, UITextViewAXExtensionKey_SuperView, ax_superview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
