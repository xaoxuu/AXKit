//
//  NSBundle+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSBundle+AXAdd.h"

@implementation NSBundle (AXAdd)

- (NSString *)bundleName{
    return self.infoDictionary[@"CFBundleName"];
}
- (NSString *)bundleDisplayName{
    NSString *bundleName = self.localizedInfoDictionary[@"CFBundleDisplayName"];
    if (!bundleName) {
        bundleName = self.infoDictionary[@"CFBundleDisplayName"];
    }
    if (!bundleName) {
        bundleName = self.bundleName;
    }
    return bundleName;
}

- (NSString *)bundleShortVersionString{
    return self.infoDictionary[@"CFBundleShortVersionString"];
}

- (NSString *)bundleVersion{
    return self.infoDictionary[@"CFBundleVersion"];
}

+ (NSDictionary *)appLocalizedInfoDictionary{
    return self.mainBundle.localizedInfoDictionary;
}

+ (NSDictionary *)appInfoDictionary{
    return self.mainBundle.infoDictionary;
}

+ (NSString *)appDisplayName{
    return self.mainBundle.bundleDisplayName;
}

+ (NSString *)appName{
    return self.mainBundle.bundleName;
}

+ (NSString *)appVersion{
    return self.mainBundle.bundleShortVersionString;
}

+ (NSString *)appBuildVersion{
    return self.mainBundle.bundleVersion;
}

+ (NSString *)appIconName{
    return [[self.mainBundle.infoDictionary valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
}

+ (NSString *)appLaunchImageName{
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

@end
