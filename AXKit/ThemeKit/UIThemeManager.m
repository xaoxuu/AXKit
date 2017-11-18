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
                    path = [UIThemeModel filePathWithKey:path];
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
