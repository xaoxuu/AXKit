//
//  AppServices.h
//  AXKit
//
//  Created by xaoxuu on 08/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"
#import "DefaultViewController.h"

FOUNDATION_EXTERN NSString *kBlogURL;


@interface AppServices : BaseServices

// @xaoxuu: setting icon placeholder
@property (strong, readonly, nonatomic) UIImage *placeholderForSetting;

// @xaoxuu: homePage url
@property (copy, readonly, nonatomic) NSString *homePageURL;
// @xaoxuu: blog url
@property (copy, readonly, nonatomic) NSString *blogURL;
// @xaoxuu: feedback
@property (copy, nonatomic) NSString *feedbackURL;


// @xaoxuu: default vc
@property (strong, readonly, nonatomic) DefaultViewController *defaultVC;

- (void)applyTheme;

- (void)reloadAllView;

@end
