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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [NSBundle axkitBundle];
        // 获取首选语言
        NSString *language = [NSLocale preferredLanguages].firstObject;
        // 去掉地区
        NSRange range = [language rangeOfString:@"-" options:NSBackwardsSearch];
        language = [language substringToIndex:range.location];
        bundle = [NSBundle bundleWithPath:[bundle pathForResource:language ofType:@"lproj"]];
    });
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

@implementation NSBundle (AXPrivateExtension)

+ (instancetype)axkitBundle{
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // xxx.app/AXKit.bundle（直接将AXKit源码导入项目中或使用Cocoapods或者方式导入）
        if (!bundle) {
            NSString *path = [NSBundle mainBundle].bundlePath;
            path = [[NSBundle mainBundle] pathForResource:@"AXKit" ofType:@"bundle"];
            bundle = [NSBundle bundleWithPath:path];
        }
        // xxx.app/AXKit.framework/AXKit.bundle（使用静态库方式导入）
        if (!bundle) {
            NSString *path = [[NSBundle mainBundle] bundlePath];
            path = [path stringByAppendingPathComponent:@"Frameworks/AXKit.framework"];
            bundle = [NSBundle bundleWithPath:path]; // 得到AXKit.framework
            path = [bundle pathForResource:@"AXKit" ofType:@"bundle"];
            bundle = [NSBundle bundleWithPath:path];
        }
        if (!bundle) {
            NSLog(@"com.xaoxuu.AXKit: bundle not found!");
        }
        
    });
    return bundle;
}

@end
