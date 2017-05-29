//
//  AppServices.h
//  AXKit
//
//  Created by xaoxuu on 08/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"
#import "DefaultViewController.h"
#import "ThemeColorModel.h"
#import "AppInfoModel.h"
#import "AppVersionInfoModel.h"

FOUNDATION_EXTERN NSString *kBlogURL;


@interface AppServices : BaseServices

@property (strong, readonly, nonatomic) AppInfoModel *model;

@property (strong, readonly, nonatomic) AppVersionInfoModel *latestVersion;

// @xaoxuu: setting icon placeholder
@property (strong, readonly, nonatomic) UIImage *placeholderForSetting;

// @xaoxuu: default vc
@property (strong, readonly, nonatomic) DefaultViewController *defaultVC;


- (void)applyThemeWithColor:(ThemeColorModelRow *)color completion:(void (^)())completion;

- (void)applyTheme;

- (void)reloadAllView;

- (NSString *(^)(NSString *name))assetURLWithName;


- (UIView *)copyrightTableFooter;

- (UIView *)randomTableFooter;

- (UIView *)tableFooterWithText:(NSString *)text;

- (void)checkVersionCompletion:(void (^)(VersionState state))completion;

@end
