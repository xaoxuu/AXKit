//
//  UIView+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIView+AXAdd.h"
#import "CoreGraphics+AXAdd.h"
#import "UIViewController+AXAdd.h"
#import "UIImage+AXAdd.h"

static inline __kindof UIView *UIViewFromNibNamed(NSString *name){
    return [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].firstObject;
}

@implementation UIView (AXAdd)


+ (__kindof UIView * _Nonnull (^)(NSString * _Nonnull))initWithNibName{
    return ^UIView *(NSString *name){
        return UIViewFromNibNamed(name);
    };
}

+ (__kindof UIView *(^)(CGFloat height))initWithHeight{
    return ^UIView *(CGFloat height){
        return [[self alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, height)];
    };
}

+ (__kindof UIView *(^)(CGSize size))initWithSize{
    return ^UIView *(CGSize size){
        return [[self alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    };
}

- (void)ax_layer:(void (^)(CALayer *layer))layer{
    if (layer) {
        layer(self.layer);
    }
}

- (void)ax_allSubviews:(Class)subClass action:(void (^)(__kindof UIView *subview))action {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        if (subview && action) {
            if (!subClass || [subview isKindOfClass:subClass]) {
                action(subview);
            }
        }
    }];
}

- (void)ax_allLabelsInvokeAction:(void (^)(__kindof UILabel *label))action {
    [self ax_allSubviews:[UILabel class] action:action];
}

- (void)ax_allTextFieldsInvokeAction:(void (^)(__kindof UITextField *textField))action {
    [self ax_allSubviews:[UITextField class] action:action];
}

- (void)ax_allTextViewsInvokeAction:(void (^)(__kindof UITextView *textView))action {
    [self ax_allSubviews:[UITextView class] action:action];
}

- (void)ax_allButtonsInvokeAction:(void (^)(__kindof UIButton *button))action {
    [self ax_allSubviews:[UIButton class] action:action];
}

- (void)ax_allImageViewsInvokeAction:(void (^)(__kindof UIImageView *imageView))action {
    [self ax_allSubviews:[UIImageView class] action:action];
}

- (void)ax_allSubviewsWithTagsLargerThan:(NSUInteger)largerThan andLessThan:(NSUInteger)lessThan action:(void (^)(__kindof UIView *subview))action {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        if (subview && action) {
            if (AXNumberContainedInRange(@(subview.tag), @(largerThan), @(lessThan))) {
                action(subview);
            }
        }
    }];
}

- (void)ax_allSubviewsWithTag:(NSInteger)tag action:(void (^)(__kindof UIView *subview))action {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        if (subview && action) {
            if (subview.tag == tag) {
                action(subview);
            }
        }
    }];
}

- (CGRect)frameInScreen{
    static UIView *screenView;
    if (!screenView) {
        screenView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return [self.superview convertRect:self.frame toView:screenView];
}

@end

