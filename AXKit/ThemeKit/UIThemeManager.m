//
//  UIThemeManager.m
//  AXKit
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIThemeManager.h"
#import "_AXKitBundle.h"
#import "NSUserDefaults+AXWrapper.h"
#import "NSString+AXFileStreamChainedWrapper.h"
#import "UIColor+AXExtension.h"

UIThemeManager *axThemeManager = nil;

@implementation UIThemeManager

- (void)configDefaultTheme:(void (^)(UIThemeManager *))defaultTheme{
    BOOL hasCustomTheme = NO;
    hasCustomTheme = [NSUserDefaults ax_readStringForKey:ThemeKitBundleIdentify].length;
    if (!hasCustomTheme) {
        if (defaultTheme) {
            defaultTheme(self);
        }
    }
}

- (void)applyThemeWithPath:(NSString *)path{
    axThemeManager = [UIThemeManager modelWithPath:path];
    [self saveCurrentTheme];
}
- (void)applyThemeWithEmail:(NSString *)email name:(NSString *)name{
    UIThemeModel *theme = [UIThemeModel modelWithEmail:email name:name];
    [self applyTheme:theme];
}
- (void)applyTheme:(UIThemeModel *)theme{
    axThemeManager.name = theme.name;
    axThemeManager.author = theme.author;
    axThemeManager.email = theme.email;
    axThemeManager.color = theme.color;
    axThemeManager.font = theme.font;
    axThemeManager.icon = theme.icon;
    [self saveCurrentTheme];
}
- (void)saveCurrentTheme{
    [super saveCurrentTheme];
    
    if (axThemeManager.color.theme.isLightColor) {
        [UINavigationBar appearance].tintColor = axThemeManager.color.theme.darkRatio(0.6);
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:axThemeManager.color.theme.darkRatio(0.6)}];
        [UITabBar appearance].tintColor = axThemeManager.color.theme.darkRatio(0.3);
    } else {
        [UINavigationBar appearance].tintColor = [UIColor whiteColor];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [UITabBar appearance].tintColor = axThemeManager.color.theme;
    }
    
    [UINavigationBar appearance].barStyle = UIBarStyleDefault;
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].opaque = YES;
    [UINavigationBar appearance].barTintColor = axThemeManager.color.theme;
    
    
    [UITabBar appearance].barStyle = UIBarStyleDefault;
    [UITabBar appearance].translucent = NO;
    [UITabBar appearance].opaque = YES;
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    [UITabBar appearance].tintColor = axThemeManager.color.theme;
    
    
    
    
}

- (void)updateCurrentTheme:(void (^)(UIThemeManager *))update{
    if (update) {
        update(self);
    }
    [self saveCurrentTheme];
}


#pragma mark - life circle

#pragma mark init


#pragma mark creator

// defaultManager
+ (instancetype)defaultManager{
    return [self sharedInstance];
}

// sharedInstance
+ (instancetype)sharedInstance{
    if (!axThemeManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!axThemeManager) {
                NSString *path = [NSUserDefaults ax_readStringForKey:ThemeKitBundleIdentify];
                if (path.length) {
                    path = [UIThemeModel filePathWithIdentifier:path];
                }
                if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [NSUserDefaults ax_removeObjectForKey:ThemeKitBundleIdentify];
                    path = [[_AXKitBundle axkitBundle] pathForResource:@"DefaultTheme" ofType:@"json"];
                }
                axThemeManager = [self modelWithPath:path];
                // init settings
                
//                [axThemeManager addObserver:axThemeManager forKeyPath:@"font.prefersFontSize" options:NSKeyValueObservingOptionNew context:nil];
                
            }
        });
    }
    return axThemeManager;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"font.prefersFontSize"]) {
//        [self saveCurrentTheme];
//    }
//}
//
//- (void)dealloc{
//    [axThemeManager removeObserver:axThemeManager forKeyPath:@"font.prefersFontSize"];
//}

@end
