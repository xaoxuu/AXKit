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
    if (label.text.length) {
        label.text = NSLocalizedString(label.text, nil);
    }
}

inline void AXLocalizeTextView(UITextView *textView){
    if (textView.text.length) {
        textView.text = NSLocalizedString(textView.text, nil);
    }
}

inline void AXLocalizeTextField(UITextField *textField){
    if (textField.placeholder.length) {
        textField.placeholder = NSLocalizedString(textField.placeholder, nil);
    }
    if (textField.text.length) {
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


+ (NSString *)ax_appName{
    return [self.ax_localizedInfoDictionary objectForKey:@"CFBundleDisplayName"] ?: [self.ax_infoDictionary objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)ax_appVersion{
    return [self.ax_infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)ax_appBuild{
    return [self.ax_infoDictionary objectForKey:@"CFBundleVersion"];
}

+ (NSString *)ax_appIconPath{
    return [[self.ax_infoDictionary valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"]lastObject];
}

+ (UIImage *)ax_appIcon{
    return [UIImage imageNamed:[self ax_appIconPath]];
}

+ (NSString *)ax_appLaunchImagePath{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageNamePath = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageNamePath = dict[@"UILaunchImageName"];
        }
    }
    return launchImageNamePath;
}

+ (UIImage *)ax_appLaunchImage{
    return [UIImage imageNamed:[self ax_appLaunchImagePath]];
}



+ (NSDictionary *)ax_localizedInfoDictionary{
    return [[NSBundle mainBundle] localizedInfoDictionary];
}

+ (NSDictionary *)ax_infoDictionary{
    return [[NSBundle mainBundle] infoDictionary];
}


@end
