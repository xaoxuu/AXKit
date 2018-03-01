
//  UIThemeManager.m
//  AXKit
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIThemeManager.h"
#import "ThemeKit.h"
#import "_AXKitBundle.h"
#import "NSUserDefaults+AXWrapper.h"
#import "NSString+AXFileStreamChainedWrapper.h"
#import "UIColor+AXExtension.h"
#import "UIResponder+AXExtension.h"


NSString *ThemeKitNotificationColorChanged = @"com.xaoxuu.AXKit.theme.notification.ColorChanged";
NSString *ThemeKitNotificationFontChanged = @"com.xaoxuu.AXKit.theme.notification.FontChanged";
NSString *ThemeKitNotificationIconPackChanged = @"com.xaoxuu.AXKit.theme.notification.IconPackChanged";


UIThemeManager *axThemeManager = nil;

@implementation UIThemeManager


#pragma mark - life circle

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
                    path = [[NSBundle axkitBundle] pathForResource:@"DefaultTheme" ofType:@"json"];
                }
                axThemeManager = [self modelWithPath:path];
                // init settings
                
            }
        });
    }
    return axThemeManager;
}

#pragma mark - manager

/**
 设置默认的颜色配置（会被用户的更改覆盖，一般用在appDelegate中）
 
 @param defaultTheme 默认的颜色配置
 */
- (void)configDefaultTheme:(void (^)(UIThemeManager *))defaultTheme{
    BOOL hasCustomTheme = NO;
    hasCustomTheme = [NSUserDefaults ax_readStringForKey:ThemeKitBundleIdentify].length;
    if (!hasCustomTheme) {
        if (defaultTheme) {
            defaultTheme(self);
        }
    }
}

/**
 应用主题
 
 @param path 主题文件路径
 */
- (void)applyThemeWithPath:(NSString *)path{
    UIThemeManager *theme = [UIThemeManager modelWithPath:path];
    [self applyTheme:theme];
}

/**
 应用主题
 
 @param email 主题作者邮箱
 @param name 主题名
 */
- (void)applyThemeWithEmail:(NSString *)email name:(NSString *)name{
    UIThemeModel *theme = [UIThemeModel modelWithEmail:email name:name];
    [self applyTheme:theme];
}

/**
 应用主题
 
 @param theme 主题
 */
- (void)applyTheme:(UIThemeModel *)theme{
    axThemeManager.info = theme.info;
    axThemeManager.color = theme.color;
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeKitNotificationColorChanged object:nil];
    axThemeManager.font = theme.font;
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeKitNotificationFontChanged object:nil];
    axThemeManager.icon = theme.icon;
     [[NSNotificationCenter defaultCenter] postNotificationName:ThemeKitNotificationIconPackChanged object:nil];
    [self saveCurrentThemeAndUpdateUI];
}

/**
 更新主题色
 
 @param update 主题色
 */
- (void)updateCurrentColorTheme:(void (^)(UIThemeColorModel *color))update{
    [self updateCurrentTheme:^(UIThemeManager *theme) {
        if (update) {
            update(theme.color);
            [[NSNotificationCenter defaultCenter] postNotificationName:ThemeKitNotificationColorChanged object:nil];
        }
    }];
}

/**
 更新主题字体
 
 @param update 主题字体
 */
- (void)updateCurrentFontTheme:(void (^)(UIThemeFontModel *font))update{
    [self updateCurrentTheme:^(UIThemeManager *theme) {
        if (update) {
            update(theme.font);
            [[NSNotificationCenter defaultCenter] postNotificationName:ThemeKitNotificationFontChanged object:nil];
        }
    }];
}



#pragma mark - util


/**
 获取所有已下载的主题
 
 @return 所有已下载的主题
 */
- (NSArray<UIThemeModel *> *)getAllDownloadedThemes{
    NSMutableArray<UIThemeModel *> *models = [NSMutableArray array];
    [ThemeKitBundleIdentify.docPath.subpaths(@"json") enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIThemeModel *model = [UIThemeModel modelWithPath:obj];
        [models addObject:model];
    }];
    return models;
}

/**
 删除主题
 
 @param theme 主题
 */
- (void)deleteTheme:(UIThemeModel *)theme{
    theme.filePath.removeFile();
}

/**
 删除所有主题
 */
- (void)deleteAllThemes{
    [UIThemeModel filePathWithIdentifier:@""].removeFile();
}

/**
 为navigationBar更新主题
 
 @param navigationBar navigationBar
 */
- (void)updateThemeForNavigationBar:(UINavigationBar *)navigationBar{
    navigationBar.translucent = NO;
    navigationBar.barTintColor = axThemeManager.color.theme;
    if (axThemeManager.color.theme.isLightColor) {
        navigationBar.tintColor = axThemeManager.color.theme.darkRatio(0.7);
        navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:axThemeManager.color.theme.darkRatio(0.7)};
        if (@available(iOS 11.0, *)) {
            // on newer versions
            navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:axThemeManager.color.theme.darkRatio(0.7)};
        }
    } else {
        navigationBar.tintColor = [UIColor whiteColor];
        navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        if (@available(iOS 11.0, *)) {
            // on newer versions
            navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        }
    }
}

/**
 为tabBar更新主题
 
 @param tabBar tabBar
 */
- (void)updateThemeForTabBar:(UITabBar *)tabBar{
    tabBar.translucent = NO;
    tabBar.barTintColor = [UIColor whiteColor];
    if (axThemeManager.color.theme.isLightColor) {
        tabBar.tintColor = axThemeManager.color.theme.darkRatio(0.2);
    } else {
        tabBar.tintColor = axThemeManager.color.theme;
    }
}

#pragma mark - priv

- (void)updateCurrentTheme:(void (^)(UIThemeManager *theme))update{
    if (update) {
        update(self);
    }
    [self saveCurrentThemeAndUpdateUI];
}


- (void)saveCurrentThemeAndUpdateUI{
    // save file
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self dictionaryWithModel] options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.filePath.saveFile(jsonString);
    // save user defaults
    [NSUserDefaults ax_setString:self.identifier forKey:ThemeKitBundleIdentify];
    
    // update ui
    [self updateThemeForNavigationBar:[UINavigationBar appearance]];
    [self updateThemeForTabBar:[UITabBar appearance]];
    
}

@end
