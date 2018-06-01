//
//  AXThemeManager.h
//  AXKit
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXThemeModel.h"



/**
 com.xaoxuu.AXKit.theme
 */
FOUNDATION_EXTERN NSString *ThemeKitBundleIdentify;

/**
 主题色更新通知
 */
FOUNDATION_EXTERN NSNotificationName ThemeKitNotificationColorChanged;

/**
 主题字体更新通知
 */
FOUNDATION_EXTERN NSNotificationName ThemeKitNotificationFontChanged;

/**
 主题图标更新通知
 */
FOUNDATION_EXTERN NSNotificationName ThemeKitNotificationIconPackChanged;



@class AXThemeManager;
extern AXThemeManager *axThemeManager;

@interface AXThemeManager : AXThemeModel


#pragma mark - life circle

+ (instancetype)sharedInstance;


#pragma mark - manager

/**
 设置默认的颜色配置（会被用户的更改覆盖，一般用在appDelegate中）
 
 @param defaultTheme 默认的颜色配置
 */
- (void)configDefaultTheme:(void (^)(AXThemeManager *theme))defaultTheme;

/**
 应用主题

 @param path 主题文件路径
 */
- (void)applyThemeWithPath:(NSString *)path;

/**
 应用主题

 @param email 主题作者邮箱
 @param name 主题名
 */
- (void)applyThemeWithEmail:(NSString *)email name:(NSString *)name;

/**
 应用主题

 @param theme 主题
 */
- (void)applyTheme:(AXThemeModel *)theme;


/**
 更新主题色

 @param update 主题色
 */
- (void)updateCurrentColorTheme:(void (^)(UIThemeColorModel *color))update;

/**
 更新主题字体

 @param update 主题字体
 */
- (void)updateCurrentFontTheme:(void (^)(UIThemeFontModel *font))update;


#pragma mark - util

/**
 获取所有已下载的主题

 @return 所有已下载的主题
 */
- (NSArray<AXThemeModel *> *)getAllDownloadedThemes;

/**
 删除主题

 @param theme 主题
 */
- (void)deleteTheme:(AXThemeModel *)theme;

/**
 删除所有主题
 */
- (void)deleteAllThemes;


/**
 为navigationBar更新主题

 @param navigationBar navigationBar
 */
- (void)updateThemeForNavigationBar:(UINavigationBar *)navigationBar;

/**
 为tabBar更新主题

 @param tabBar tabBar
 */
- (void)updateThemeForTabBar:(UITabBar *)tabBar;

@end
