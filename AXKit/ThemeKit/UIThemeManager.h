//
//  UIThemeManager.h
//  AXKit
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIThemeModel.h"

@class UIThemeManager;
extern UIThemeManager *axThemeManager;

@interface UIThemeManager : UIThemeModel

/**
 设置默认的颜色配置（会被新的更改覆盖，一般用在appDelegate中）
 
 @param defaultTheme 默认的颜色配置
 */
- (void)configDefaultTheme:(void (^)(UIThemeManager *theme))defaultTheme;

/**
 应用主题

 @param path 主题文件路径
 */
- (void)applyThemeWithPath:(NSString *)path;
- (void)applyThemeWithEmail:(NSString *)email name:(NSString *)name;
- (void)applyTheme:(UIThemeModel *)theme;

- (void)updateCurrentColorTheme:(void (^)(UIThemeColorModel *color))update;
- (void)updateCurrentFontTheme:(void (^)(UIThemeFontModel *font))update;


+ (instancetype)sharedInstance;

@end
