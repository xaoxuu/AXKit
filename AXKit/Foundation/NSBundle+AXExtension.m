//
//  NSBundle+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSBundle+AXExtension.h"
#import "UIView+AXExtension.h"


inline void AXLocalizedLabel(UILabel *label){
    label.text = NSLocalizedString(label.text, nil);
}

inline void AXLocalizedTextView(UITextView *textView){
    textView.text = NSLocalizedString(textView.text, nil);
}

inline void AXLocalizedTextField(UITextField *textField){
    textField.placeholder = NSLocalizedString(textField.placeholder, nil);
    textField.text = NSLocalizedString(textField.text, nil);
}


inline void AXLocalizedAllLabelsInView(UIView *view){
    [view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        if (subview.subviews.count) {
            AXLocalizedAllLabelsInView(subview);
        }
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *lb = subview;
            AXLocalizedLabel(lb);
        }
    }];
}

inline void AXLocalizedAllTextFieldsInView(UIView *view){
    [view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        if (subview.subviews.count) {
            AXLocalizedAllTextFieldsInView(subview);
        }
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *tf = subview;
            AXLocalizedTextField(tf);
        }
    }];
}

inline void AXLocalizedAllTextViewsInView(UIView *view){
    [view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        if (subview.subviews.count) {
            AXLocalizedAllTextViewsInView(subview);
        }
        if ([subview isKindOfClass:[UITextView class]]) {
            UITextView *tv = subview;
            AXLocalizedTextView(tv);
        }
    }];
}

inline void AXLocalizedAllSubviewsInView(UIView *view){
    [view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        if (subview.subviews.count) {
            AXLocalizedAllSubviewsInView(subview);
        }
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *lb = subview;
            AXLocalizedLabel(lb);
        } else if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *tf = subview;
            AXLocalizedTextField(tf);
        } else if ([subview isKindOfClass:[UITextView class]]) {
            UITextView *tv = subview;
            AXLocalizedTextView(tv);
        }
    }];
}

@implementation NSBundle (AXExtension)

@end
