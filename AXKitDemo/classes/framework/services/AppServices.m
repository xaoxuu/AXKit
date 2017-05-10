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

@interface AppServices ()

// @xaoxuu: json file
@property (strong, nonatomic) NSDictionary *jsonFile;

@end

@implementation AppServices

- (instancetype)init{
    if (self = [super init]) {
        _placeholderForSetting = [UIImage imageNamed:@"setting_default"];
        
        _homePageURL = self.jsonFile[@"homePageURL"];
        _blogURL = self.jsonFile[@"blogURL"];
        _feedbackURL = self.jsonFile[@"feedbackURL"];
        _defaultVC = [DefaultViewController new];
        
    }
    return self;
}

- (NSDictionary *)jsonFile{
    if (!_jsonFile) {
        _jsonFile = @"urls".mainBundlePath.readJson;
    }
    return _jsonFile;
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


- (void)applyTheme{
    CGFloat r = axColor.theme.redValue;
    CGFloat g = axColor.theme.greenValue;
    CGFloat b = axColor.theme.blueValue;
    CGFloat x = r*g*b;
    CGFloat y = r+g+b;
    if (2*x*y+x+y < 2) {
        [UINavigationBar appearance].tintColor = axColor.white;
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:axColor.white}];
    } else {
        [UINavigationBar appearance].tintColor = axColor.black;
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:axColor.black}];
        
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
                    if (2*x*y+x+y < 2) {
                        navVC.navigationBar.tintColor = axColor.white;
                        [navVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:axColor.white}];
                    } else {
                        navVC.navigationBar.tintColor = axColor.black;
                        [navVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:axColor.black}];
                        
                    }
                }
            }];
//            tabbarVC.tabBar.tintColor = axColor.theme;
            if (2*x*y+x+y < 2) {
                tabbarVC.tabBar.tintColor = axColor.theme;
            } else {
                tabbarVC.tabBar.tintColor = axColor.theme.dark;
                
            }
        }
    }];
    
    
}

@end
