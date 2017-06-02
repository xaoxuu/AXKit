//
//  AppServices.m
//  AXKit
//
//  Created by xaoxuu on 08/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AppServices.h"
#import "BaseTabBarController.h"
#import "BaseNavController.h"
#import "DataAccessLayer.h"
#import "MJExtension.h"


#define daLayer [DataAccessLayer sharedInstance]

static NSArray<NSString *> *footerArray;

@interface AppServices () <ServicesPrivateMethod>


@end

@implementation AppServices

- (instancetype)init{
    if (self = [super init]) {
        
        _placeholderForSetting = daLayer.assets.setting.placeholder.image;
        
        _model = [AppInfoModel mj_objectWithKeyValues:@"appinfo".json.mainBundlePath.readJson];
        
        _defaultVC = [DefaultViewController new];
        
        [NSBlockOperation ax_delay:2 performInBackground:^{
            [self checkVersionCompletion:^(VersionState state) {
                [self allDelegates:^(id<AppServicesDelegate> delegate) {
                    [delegate didDiscoverRemoteVersion:self.remoteVersion];
                }];
            }];
        }];
        
    }
    return self;
}



- (void)reloadAllView{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIView *view = vc.view.subviews.lastObject;
    [view removeFromSuperview];
    [vc.view addSubview:view];
    [vc loadViewIfNeeded];
    
    [view setNeedsLayout];
//    [[UIApplication sharedApplication].keyWindow setRootViewController:vc];
    
    
}


- (void)applyThemeWithColor:(ThemeColorModelRow *)color completion:(void (^)())completion{
    
    NSString *msg = [NSString stringWithFormat:NSLocalizedString(@"将应用此主题:%@", nil),color.title];
    UIColor *tmp = [UIColor colorWithHexString:color.hex];
    [services.alert alertForConfirmTheme:tmp message:msg completion:^{
        axColor.theme = tmp;
        [services.app applyTheme];
        if (completion) {
            completion();
        }
    }];
    
}

- (void)applyTheme{

    if (axColor.theme.isLightColor) {
        [UINavigationBar appearance].tintColor = axColor.theme.darkRatio(0.6);
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:axColor.theme.darkRatio(0.6)}];
        [UITabBar appearance].tintColor = axColor.theme.darkRatio(0.3);
    } else {
        [UINavigationBar appearance].tintColor = axColor.white;
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:axColor.white}];
        [UITabBar appearance].tintColor = axColor.theme;
    }
    
    [UINavigationBar appearance].barStyle = UIBarStyleDefault;
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].opaque = YES;
    [UINavigationBar appearance].barTintColor = axColor.theme;
    
    
    [UITabBar appearance].barStyle = UIBarStyleDefault;
    [UITabBar appearance].translucent = NO;
    [UITabBar appearance].opaque = YES;
    [UITabBar appearance].barTintColor = axColor.white;
    [UITabBar appearance].tintColor = axColor.theme;

    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BaseTabBarController class]]) {
            BaseTabBarController *tabbarVC = obj;
            [tabbarVC.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[BaseNavController class]]) {
                    BaseNavController *navVC = obj;
                    navVC.navigationBar.barTintColor = axColor.theme;
                    if (axColor.theme.isLightColor) {
                        navVC.navigationBar.tintColor = axColor.theme.darkRatio(0.6);
                        [navVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:axColor.theme.darkRatio(0.6)}];
                        
                    } else {
                        navVC.navigationBar.tintColor = axColor.white;
                        [navVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:axColor.white}];
                        
                    }
                }
            }];
//            tabbarVC.tabBar.tintColor = axColor.theme;
            if (axColor.theme.isLightColor) {
                tabbarVC.tabBar.tintColor = axColor.theme.darkRatio(0.3);
            } else {
                tabbarVC.tabBar.tintColor = axColor.theme;
            }
        }
    }];
    
    
}


- (NSString *(^)(NSString *name))assetURLWithName{
    return ^(NSString *name){
        name = [name stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
        return [NSString stringWithFormat:@"%@/%@.%@",@"https://github.com/xaoxuu/assets/blob/axkit",name,@"png?raw=true"];
    };
}


- (UIView *)copyrightTableFooter{
    return [self tableFooterWithText:self.model.copyright];
}

- (UIView *)randomTableFooter{
    return [self tableFooterWithText:[self randomTips]];
}

- (UIView *)tableFooterWithText:(NSString *)text{
    UIView *footer = UIViewWithHeight(64);
    // @xaoxuu: label
    UILabel *label = [[UILabel alloc] initWithFrame:footer.bounds];
    [footer addSubview:label];
    label.textColor = [UIColor lightGrayColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];
    label.text = text;
    
    [label sizeToFit];
    label.width += kMarginNormal;
    label.centerX = 0.5*footer.width;
    label.centerY = 0.5*footer.height;
    // @xaoxuu: left line
    CALayer *line_left = [CALayer layer];
    line_left.backgroundColor = axColor.separatorColor.lightRatio(0.1).CGColor;
    line_left.height = 0.5;
    line_left.width = 0.5 * (footer.width - label.width) - 4;
    line_left.centerY = 0.5*footer.height;
    [footer.layer addSublayer:line_left];
    line_left.left = 0;
    
    // @xaoxuu: right line
    CALayer *line_right = [CALayer layer];
    line_right.backgroundColor = axColor.separatorColor.lightRatio(0.1).CGColor;
    line_right.height = 0.5;
    line_right.width = 0.5 * (footer.width - label.width) - 4;
    line_right.centerY = 0.5*footer.height;
    [footer.layer addSublayer:line_right];
    line_right.right = footer.width;
    
    
    
    return footer;
}


- (NSString *)randomTips{
    if (!footerArray) {
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:@"footer_rhesis".json.mainBundlePath.readJson];
        if (arrM) {
            NSString *tmp = self.model.copyright;
            [arrM addObject:tmp];
            footerArray = arrM;
        }   
    }
    if (footerArray.count) {
        int i = arc4random_uniform((uint32_t)footerArray.count);
        return footerArray[i];
    }
    return self.model.copyright;
}

- (void)checkVersionCompletion:(void (^)(VersionState state))completion{
    if (!completion) {
        return;
    }
    daLayer.network.URLString = services.git.model.releaseLogURL;
    [daLayer.network getURLCompletion:^(id response) {
        NSDictionary *dataDict = response;
        GitHubIssueListModel *list = [GitHubIssueListModel modelWithDictionary:dataDict];
        _remoteVersion = [AppVersionInfoModel versionWithModel:list.items.firstObject];
        
        VersionLaterThanVersion(_remoteVersion.name, [NSBundle ax_appVersion], ^(BOOL later) {
            if (later) {
                // @xaoxuu: 有新版本
                NSString *msg = [AppVersionInfoModel versionDescriptionWithModel:_remoteVersion];
                [UIAlertController ax_showAlertWithTitle:NSLocalizedString(@"发现新版本", nil) message:msg action:^(UIAlertController * _Nonnull alert) {
                    [alert ax_addCancelAction];
                    [alert ax_addDefaultActionWithTitle:@"Update" handler:^(UIAlertAction * _Nonnull sender) {
                        [[UIApplication sharedApplication] openURL:self.model.updateURL.absoluteURL];
                    }];
                }];
                completion(VersionStateOld);
            } else {
                completion(VersionStateLatest);
            }
        }, ^(NSError * _Nonnull error) {
            AXLogError(error);
        });
        
        
    } fail:^(NSError *error) {
        
    }];
}



@end
