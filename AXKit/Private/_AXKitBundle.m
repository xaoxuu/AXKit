//
//  _AXKitBundle.m
//  AXKit
//
//  Created by xaoxuu on 26/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "_AXKitBundle.h"


inline NSString *NSLocalizedStringFromAXKit(NSString *key){
    static NSBundle *bundle;
    if (!bundle) {
        bundle = [AXBundle axkitBundle];
        // 获取首选语言
        NSString *language = [NSLocale preferredLanguages].firstObject;
        // 去掉地区
        if([language containsString:@"-"]) {
            NSRange range = [language rangeOfString:@"-" options:NSBackwardsSearch];
            language = [language substringToIndex:range.location];
        }
        bundle = [NSBundle bundleWithPath:[bundle pathForResource:language ofType:@"lproj"]];
    }
    NSString *localizedString = [bundle localizedStringForKey:key value:nil table:nil];
    if (localizedString.length) {
        return localizedString;
    } else {
        // 首选语言没有，第二优先级为英语
        localizedString = [[NSBundle bundleWithPath:[bundle pathForResource:@"en" ofType:@"lproj"]] localizedStringForKey:key value:nil table:nil];
        if (localizedString.length) {
            return localizedString;
        } else {
            return key;
        }
    }
}


@implementation AXBundle

+ (NSBundle *)mainBundle{
    return [AXBundle axkitBundle];
}

+ (instancetype)axkitBundle{
    static AXBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // xxx.app/AXKit.bundle（直接将AXKit源码导入项目中或使用Cocoapods或者方式导入）
        if (!bundle) {
            NSString *path = [[AXBundle bundleForClass:AXBundle.class] pathForResource:@"AXKit" ofType:@"bundle"];
            bundle = [AXBundle bundleWithPath:path];
        }
        if (!bundle) {
            NSLog(@"com.xaoxuu.AXKit: 'AXKit.bundle' not found!");
        }
        
    });
    return bundle;
}

@end

