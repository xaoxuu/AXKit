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

#define daLayer [DataAccessLayer sharedInstance]


@interface AppServices ()


@end

@implementation AppServices

- (instancetype)init{
    if (self = [super init]) {
        
        _placeholderForSetting = daLayer.assets.setting.placeholder.image;
        
        _homePageURL = daLayer.developer.homePageURL;
        _blogURL = daLayer.developer.blogURL;
        _feedbackURL = daLayer.developer.feedbackURL;
        _feedbackEmail = daLayer.developer.feedbackEmail;
        
        _defaultVC = [DefaultViewController new];
        
        
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
    
    NSString *msg = [NSString stringWithFormat:@"将应用此主题:%@",color.title];
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


- (UIView *)tableFooter{
    UIView *footer = UIViewWithHeight(64);
    CALayer *line = [CALayer layer];
    line.width = footer.width;
    line.height = 0.5;
    line.centerY = 0.5*footer.height;
    line.backgroundColor = [UIColor groupTableViewBackgroundColor].darkRatio(0.1).CGColor;
    [footer.layer addSublayer:line];
    UILabel *label = [[UILabel alloc] initWithFrame:footer.bounds];
    [footer addSubview:label];
    label.textColor = [UIColor darkGrayColor];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.text = [self randomTips];
    [label sizeToFit];
    label.width += kMarginNormal;
    label.centerX = 0.5*footer.width;
    label.centerY = 0.5*footer.height;
    return footer;
}


- (NSString *)randomTips{
    int i = arc4random_uniform(150);
    if (i < 20) {
        return @"😏你还想看什么";
    } else if (i < 40) {
        return @"我可是有底线的";
    } else if (i < 60) {
        return @"😱没有更多了";
    } else if (i < 80) {
        return @"我可是有底线的😡";
    } else if (i < 100) {
        return @"⚠️高压危险";
    } else if (i < 110) {
        return @"🚫少儿不宜";
    } else if (i < 120) {
        return @"🙄";
    } else if (i < 130) {
        return @"👌加载完毕";
    } else if (i < 140) {
        return @"内有🐶恶犬";
    } else if (i < 150) {
        return @"😂";
    }
    
    
    return @"";
    
    
}

@end
