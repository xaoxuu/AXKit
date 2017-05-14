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

FOUNDATION_EXTERN NSString *kBlogURL;


@interface AppServices : BaseServices




// @xaoxuu: setting icon placeholder
@property (strong, readonly, nonatomic) UIImage *placeholderForSetting;

// @xaoxuu: homePage url
@property (copy, readonly, nonatomic) NSString *homePageURL;
// @xaoxuu: blog url
@property (copy, readonly, nonatomic) NSString *blogURL;
// @xaoxuu: feedback
@property (copy, readonly, nonatomic) NSString *feedbackURL;

// @xaoxuu: feedback email
@property (copy, readonly, nonatomic) NSString *feedbackEmail;

// @xaoxuu: default vc
@property (strong, readonly, nonatomic) DefaultViewController *defaultVC;


- (void)applyThemeWithColor:(ThemeColorModelRow *)color completion:(void (^)())completion;

- (void)applyTheme;

- (void)reloadAllView;

- (NSString *(^)(NSString *name))assetURLWithName;

@end
