//
//  _AXKitBundle.m
//  AXKit
//
//  Created by xaoxuu on 26/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "_AXKitBundle.h"
#import "NSString+AXAdd.h"

inline NSString *NSLocalizedStringFromAXKit(NSString *key){
    static NSBundle *bundle;
    if (!bundle) {
        bundle = [AXBundle axkitBundle];
    }
    return AXLocalizedStringFromTableInBundle(key, nil, bundle);
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

