//
//  _AXKitBundle.m
//  AXKit
//
//  Created by xaoxuu on 26/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "_AXKitBundle.h"

static NSBundle *bundle = nil;

inline NSString *NSLocalizedStringFromAXKit(NSString *key){
    return NSLocalizedStringFromTableInBundle(key, nil, [_AXKitBundle axkitBundle], nil) ?: key;
}

@implementation _AXKitBundle

+ (instancetype)axkitBundle{
    static _AXKitBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // xxx.app/AXKit.bundle（直接将AXKit源码导入项目中或使用Cocoapods或者方式导入）
        if (!bundle) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"AXKit" ofType:@"bundle"];
            bundle = [_AXKitBundle bundleWithPath:path];
        }
        // xxx.app/AXKit.framework/AXKit.bundle（使用静态库方式导入）
        if (!bundle) {
            NSString *path = [[NSBundle mainBundle] bundlePath];
            path = [path stringByAppendingPathComponent:@"Frameworks/AXKit.framework"];
            bundle = [_AXKitBundle bundleWithPath:path]; // 得到AXKit.framework
            path = [bundle pathForResource:@"AXKit" ofType:@"bundle"];
            bundle = [_AXKitBundle bundleWithPath:path];
        }
        if (!bundle) {
            NSLog(@"com.xaoxuu.AXKit: bundle not found!");
        }
        
    });
    return bundle;
}

@end

