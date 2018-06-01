
//  UIThemeManager.m
//  AXKit
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIThemeManager.h"


NSNotificationName ThemeKitNotificationColorChanged = @"com.xaoxuu.AXKit.theme.notification.ColorChanged";
NSNotificationName ThemeKitNotificationFontChanged = @"com.xaoxuu.AXKit.theme.notification.FontChanged";
NSNotificationName ThemeKitNotificationIconPackChanged = @"com.xaoxuu.AXKit.theme.notification.IconPackChanged";


UIThemeManager *axThemeManager = nil;


static inline NSArray<NSString *> *themeDownloads(){
    NSString *path0 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path0 = [path0 stringByAppendingPathComponent:ThemeKitBundleIdentify];
    
    NSString *extension = @"json";
    NSMutableArray *allPaths = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path0];
    NSString *path;
    while ((path = dirEnum.nextObject) != nil) {
        if (!extension.length || [path.lastPathComponent containsString:extension]) {
            [allPaths addObject:[path0 stringByAppendingPathComponent:path]];
        }
    }
    return allPaths;
}

static inline BOOL removeFile(NSString *path){
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}


static inline CGFloat grayLevel(UIColor *color){
    CGFloat r,g,b;
    [color getRed:&r green:&g blue:&b alpha:nil];
    return r * 0.299 + g * 0.587 + b * 0.114;
}

static inline BOOL isLightColor(UIColor *color){
    if (grayLevel(color) >= 192.0/255.0) {
        // @xaoxuu: light color
        return YES;
    } else {
        // @xaoxuu: dark color
        return NO;
    }
}
static inline UIColor *darkRatio(UIColor *color, CGFloat ratio){
    CGFloat red = 0.0,green = 0.0,blue = 0.0, alpha = 1.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    red   = red   * (1 - ratio);
    green = green * (1 - ratio);
    blue  = blue  * (1 - ratio);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

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
                NSString *path = [[NSUserDefaults standardUserDefaults] stringForKey:ThemeKitBundleIdentify];
                if (path.length) {
                    path = [UIThemeModel filePathWithIdentifier:path];
                }
                if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:ThemeKitBundleIdentify];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    path = [[NSBundle bundleForClass:self.class] pathForResource:@"DefaultTheme" ofType:@"json"];
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
    hasCustomTheme = [[NSUserDefaults standardUserDefaults] stringForKey:ThemeKitBundleIdentify].length;
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
    [themeDownloads() enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    removeFile(theme.filePath);
}

/**
 删除所有主题
 */
- (void)deleteAllThemes{
    [themeDownloads() enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        removeFile(obj);
    }];
}

/**
 为navigationBar更新主题
 
 @param navigationBar navigationBar
 */
- (void)updateThemeForNavigationBar:(UINavigationBar *)navigationBar{
    navigationBar.translucent = NO;
    navigationBar.barTintColor = axThemeManager.color.theme;
    UIFont *titleFont = [UIFont fontWithName:axThemeManager.font.name size:18] ?: [UIFont systemFontOfSize:18];
    UIFont *largeTitleFont = [UIFont fontWithName:axThemeManager.font.name size:32] ?: [UIFont systemFontOfSize:32];
    if (isLightColor(self.color.theme)) {
        navigationBar.tintColor = darkRatio(self.color.theme, 0.7);
        navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:darkRatio(self.color.theme, 0.7), NSFontAttributeName:titleFont};
        if (@available(iOS 11.0, *)) {
            // on newer versions
            navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:darkRatio(self.color.theme, 0.7), NSFontAttributeName:largeTitleFont};
        }
    } else {
        navigationBar.tintColor = [UIColor whiteColor];
        navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:titleFont};
        if (@available(iOS 11.0, *)) {
            // on newer versions
            navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:largeTitleFont};
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
    if (isLightColor(self.color.theme)) {
        tabBar.tintColor = darkRatio(self.color.theme, 0.2);
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
    [jsonString writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    // save user defaults
    [[NSUserDefaults standardUserDefaults] setObject:self.identifier forKey:ThemeKitBundleIdentify];
    
    // update ui
    [self updateThemeForNavigationBar:[UINavigationBar appearance]];
    [self updateThemeForTabBar:[UITabBar appearance]];
    
}

@end
