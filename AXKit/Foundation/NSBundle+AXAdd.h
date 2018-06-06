//
//  NSBundle+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (AXAdd)

/**
 bundle display name
 
 @return bundle display name
 */
- (NSString *)ax_bundleDisplayName;

/**
 bundle name

 @return bundle name
 */
- (NSString *)ax_bundleName;


/**
 bundle short version string

 @return bundle short version string
 */
- (NSString *)ax_bundleShortVersionString;

/**
 bundle build version string

 @return bundle build version string
 */
- (NSString *)ax_bundleVersion;


/**
 main bundle id

 @return main bundle id
 */
+ (NSString *)ax_mainBundleId;

/**
 app name (CFBundleDisplayName)

 @return app name
 */
+ (NSString *)ax_appDisplayName;

/**
 app name (CFBundleDisplayName)
 
 @return app name
 */
+ (NSString *)ax_appName;

/**
 app version (CFBundleShortVersionString)

 @return app version
 */
+ (NSString *)ax_appVersion;

/**
 app build (CFBundleVersion)

 @return app build
 */
+ (NSString *)ax_appBuild;


/**
 bundle localized info dictionary

 @return bundle localized info dictionary
 */
+ (NSDictionary *)ax_localizedInfoDictionary;

/**
 bundle info dictionary

 @return bundle info dictionary
 */
+ (NSDictionary *)ax_infoDictionary;


/**
 appicon path

 @return appicon path
 */
+ (NSString *)ax_appIconPath;


/**
 appicon

 @return appicon
 */
+ (UIImage *)ax_appIcon;


/**
 启动图片路径

 @return 启动图片路径
 */
+ (NSString *)ax_appLaunchImagePath;

/**
 启动图片

 @return 启动图片
 */
+ (UIImage *)ax_appLaunchImage;

@end
