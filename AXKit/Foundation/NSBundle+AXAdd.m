//
//  NSBundle+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSBundle+AXAdd.h"
#import "UIView+AXAdd.h"



@implementation NSBundle (AXExtension)

- (NSString *)ax_bundleDisplayName{
    NSString *bundleName = [self.localizedInfoDictionary objectForKey:@"CFBundleDisplayName"];
    if (!bundleName) {
        bundleName = [self.infoDictionary objectForKey:@"CFBundleDisplayName"];
    }
    if (!bundleName) {
        bundleName = [self ax_bundleName];
    }
    return bundleName;
}
- (NSString *)ax_bundleName{
    return [self.infoDictionary objectForKey:@"CFBundleName"];
}

- (NSString *)ax_bundleShortVersionString{
    return [self.infoDictionary objectForKey:@"CFBundleShortVersionString"];;
}

- (NSString *)ax_bundleVersion{
    return [self.infoDictionary objectForKey:@"CFBundleVersion"];;
}

+ (NSString *)ax_mainBundleId{
    return [[self mainBundle] bundleIdentifier];
}

+ (NSString *)ax_appDisplayName{
    return [[self mainBundle] ax_bundleDisplayName];
}

+ (NSString *)ax_appName{
    return [[self mainBundle] ax_bundleName];
}

+ (NSString *)ax_appVersion{
    return [[self mainBundle] ax_bundleShortVersionString];
}

+ (NSString *)ax_appBuild{
    return [[self mainBundle] ax_bundleVersion];
}

+ (NSString *)ax_appIconPath{
    return [[self.ax_infoDictionary valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
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
