//
//  NSBundle+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSBundle+AXExtension.h"
#import "UIView+AXExtension.h"

inline void AXLocalizeLabel(UILabel *label){
    if (label.attributedText.length) {
        
    } else if (label.text.length) {
        label.text = NSLocalizedString(label.text, nil);
    }
}

inline void AXLocalizeTextView(UITextView *textView){
    if (textView.attributedText.length) {
        
    } else if (textView.text.length) {
        textView.text = NSLocalizedString(textView.text, nil);
    }
}

inline void AXLocalizeTextField(UITextField *textField){
    if (textField.placeholder.length) {
        textField.placeholder = NSLocalizedString(textField.placeholder, nil);
    }
    if (textField.attributedText.length) {
        
    } else if (textField.text.length) {
        textField.text = NSLocalizedString(textField.text, nil);
    }
    
}


inline void AXLocalizeAllLabelsInView(UIView *view){
    [view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        if (subview.subviews.count) {
            AXLocalizeAllLabelsInView(subview);
        }
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *lb = subview;
            AXLocalizeLabel(lb);
        }
    }];
}

inline void AXLocalizeAllTextFieldsInView(UIView *view){
    [view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        if (subview.subviews.count) {
            AXLocalizeAllTextFieldsInView(subview);
        }
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *tf = subview;
            AXLocalizeTextField(tf);
        }
    }];
}

inline void AXLocalizeAllTextViewsInView(UIView *view){
    [view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        if (subview.subviews.count) {
            AXLocalizeAllTextViewsInView(subview);
        }
        if ([subview isKindOfClass:[UITextView class]]) {
            UITextView *tv = subview;
            AXLocalizeTextView(tv);
        }
    }];
}

inline void AXLocalizeAllSubviewsInView(UIView *view){
    [view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        if (subview.subviews.count) {
            AXLocalizeAllSubviewsInView(subview);
        }
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *lb = subview;
            AXLocalizeLabel(lb);
        } else if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *tf = subview;
            AXLocalizeTextField(tf);
        } else if ([subview isKindOfClass:[UITextView class]]) {
            UITextView *tv = subview;
            AXLocalizeTextView(tv);
        }
    }];
}

@implementation NSBundle (AXExtension)

@end
