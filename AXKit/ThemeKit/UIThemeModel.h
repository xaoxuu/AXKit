//
//  UIThemeModel.h
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *ThemeKitBundleIdentify;

FOUNDATION_EXTERN NSString *ThemeKitNotificationThemeColorChanged;

FOUNDATION_EXTERN NSString *ThemeKitNotificationFontNameChanged;
FOUNDATION_EXTERN NSString *ThemeKitNotificationFontSizeChanged;

FOUNDATION_EXTERN NSString *ThemeKitNotificationIconPackChanged;

@class UIThemeColorModel,UIThemeFontModel,UIThemeIconModel;

@interface UIThemeModel : NSObject


/**
 theme name
 */
@property (copy, nonatomic) NSString *name;

/**
 theme author
 */
@property (copy, nonatomic) NSString *author;

/**
 theme author's email
 */
@property (copy, nonatomic) NSString *email;

/**
 theme of color
 */
@property (strong, nonatomic) UIThemeColorModel *color;

/**
 theme of font
 */
@property (strong, nonatomic) UIThemeFontModel *font;

/**
 theme of icon
 */
@property (strong, nonatomic) UIThemeIconModel *icon;

+ (instancetype)modelWithPath:(NSString *)path;


/**
 保存当前主题
 */
- (void)saveCurrentTheme;


- (void)deleteThemeFile;
+ (void)clearAllThemes;

- (NSString *)key;
+ (NSString *)filePathWithKey:(NSString *)key;

@end

@interface UIThemeColorModel : NSObject


/**
 background color
 */
@property (strong, nonatomic) UIColor *background;
/**
 theme color
 */
@property (strong, nonatomic) UIColor *theme;
/**
 accent color
 */
@property (strong, nonatomic) UIColor *accent;

/**
 组tableview背景色
 */
@property (strong, nonatomic) UIColor *groupTableViewBackground;

/**
 分割线颜色
 */
@property (strong, nonatomic) UIColor *separatorColor;


+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end

@interface UIThemeFontModel : NSObject

/**
 偏好的字号，默认值为系统建议字号：14。
 当此数值变更时，custom的字号以相同的比例变更。
 */
@property (assign, nonatomic) CGFloat prefersFontSize;



// @xaoxuu: system small = 12
@property (strong, readonly, nonatomic) UIFont *systemSmall;
// @xaoxuu: system normal = 14
@property (strong, readonly, nonatomic) UIFont *systemNormal;



// @xaoxuu: normal
@property (strong, readonly, nonatomic) UIFont *customSmall;
@property (strong, readonly, nonatomic) UIFont *customBoldSmall;
// @xaoxuu: normal
@property (strong, readonly, nonatomic) UIFont *customNormal;
@property (strong, readonly, nonatomic) UIFont *customBoldNormal;
// @xaoxuu: normal
@property (strong, readonly, nonatomic) UIFont *customLarge;
@property (strong, readonly, nonatomic) UIFont *customBoldLarge;


- (UIFont *)fontWithCustomPrefersFontSize:(CGFloat)size;
- (UIFont *)boldFontWithCustomPrefersFontSize:(CGFloat)size;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end

@interface UIThemeIconModel : NSObject


+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
