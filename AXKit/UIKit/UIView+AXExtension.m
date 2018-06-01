//
//  UIView+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIView+AXExtension.h"
#import "CoreGraphics+AXExtension.h"
#import "UIViewController+AXExtension.h"

inline UIView *UIViewWithHeight(CGFloat height){
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, height)];
}

inline UIView *UIMaskViewWithSizeAndCornerRadius(CGSize size, CGFloat cornerRadius){
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = cornerRadius;
    return view;
}

inline __kindof UIView *UIViewFromNibNamed(NSString *name){
    return [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].firstObject;
}


@implementation UIView (AXExtension)


- (void)ax_layer:(void (^)(CALayer *layer))layer{
    if (layer) {
        layer(self.layer);
    }
}

- (void)ax_removeAllSubviews:(Class)subClass {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        if (!subClass || [subview isKindOfClass:subClass]) {
            [subview removeFromSuperview];
        }
    }];
}

- (void)ax_eachSubview:(Class)subClass action:(void (^)(__kindof UIView *subview))action {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        if (subview && action) {
            if (!subClass || [subview isKindOfClass:subClass]) {
                action(subview);
            }
        }
    }];
}

- (void)ax_eachLabelInvokeAction:(void (^)(__kindof UILabel *label))action {
    [self ax_eachSubview:[UILabel class] action:action];
}

- (void)ax_eachTextFieldInvokeAction:(void (^)(__kindof UITextField *textField))action {
    [self ax_eachSubview:[UITextField class] action:action];
}

- (void)ax_eachTextViewInvokeAction:(void (^)(__kindof UITextView *textView))action {
    [self ax_eachSubview:[UITextView class] action:action];
}

- (void)ax_eachButtonInvokeAction:(void (^)(__kindof UIButton *button))action {
    [self ax_eachSubview:[UIButton class] action:action];
}

- (void)ax_eachImageViewInvokeAction:(void (^)(__kindof UIImageView *imageView))action {
    [self ax_eachSubview:[UIImageView class] action:action];
}


- (void)ax_eachSubviewWithTagsInRange:(AXIntegerRange)tagRange action:(void (^)(__kindof UIView *subview))action {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        if (subview && action) {
            if (AXNumberContainedInRange(@(subview.tag), @(tagRange.minValue), @(tagRange.maxValue))) {
                action(subview);
            }
        }
    }];
}

- (void)ax_eachSubviewWithTag:(NSInteger)tag action:(void (^)(__kindof UIView *subview))action {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        if (subview && action) {
            if (subview.tag == tag) {
                action(subview);
            }
        }
    }];
}

+ (instancetype)ax_roundedViewWithFrame:(CGRect)rect {
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 0.5 * fmin(rect.size.width, rect.size.height);
    return view;
}

- (CGRect)frameInScreen{
    UIView *main = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return [self.superview convertRect:self.frame toView:main];
}


- (void)ax_fillWithRandomColor{
    self.backgroundColor = [UIColor colorWithRed:(float)(arc4random()%256)/256 green:(float)(arc4random()%256)/256 blue:(float)(arc4random()%256)/256 alpha:1.0];
}


@end

