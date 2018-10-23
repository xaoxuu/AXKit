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
 bundle name

 @return bundle name
 */
- (NSString *)bundleName;

/**
 bundle display name

 @return bundle display name
 */
- (NSString *)bundleDisplayName;

/**
 bundle short version string

 @return bundle short version string
 */
- (NSString *)bundleShortVersionString;

/**
 bundle build version string

 @return bundle build version string
 */
- (NSString *)bundleVersion;



/**
 main bundle localized info dictionary
 
 @return bundle localized info dictionary
 */
+ (NSDictionary *)appLocalizedInfoDictionary;

/**
 main bundle info dictionary
 
 @return bundle info dictionary
 */
+ (NSDictionary *)appInfoDictionary;


/**
 app display name (CFBundleDisplayName)

 @return app display name
 */
+ (NSString *)appDisplayName;

/**
 app name (CFBundleName)
 
 @return app name
 */
+ (NSString *)appName;

/**
 app version (CFBundleShortVersionString)

 @return app version
 */
+ (NSString *)appVersion;

/**
 app build (CFBundleVersion)

 @return app build
 */
+ (NSString *)appBuildVersion;

/**
 appicon name

 @return appicon name
 */
+ (NSString *)appIconName;

/**
 launch image name

 @return launch image name
 */
+ (NSString *)appLaunchImageName;

@end
