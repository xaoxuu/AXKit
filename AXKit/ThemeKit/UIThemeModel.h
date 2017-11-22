//
//  UIThemeModel.h
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>



@class UIThemeColorModel,UIThemeFontModel,UIThemeIconModel, UIThemeInfoModel;

@interface UIThemeModel : NSObject


/**
 theme info
 */
@property (strong, nonatomic) UIThemeInfoModel *info;

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
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)modelWithEmail:(NSString *)email name:(NSString *)name;
- (NSMutableDictionary *)dictionaryWithModel;


/**
 保存当前主题
 */
//- (void)saveCurrentTheme;


/**
 删除当前主题文件
 */
//- (void)deleteThemeFile;

/**
 主题文件路径

 @return 主题文件路径
 */
- (NSString *)filePath;

/**
 主题id

 @return 主题id
 */
- (NSString *)identifier;



//+ (void)deleteAllThemes;
+ (NSString *)identifierWithEmail:(NSString *)email name:(NSString *)name;
+ (NSString *)filePathWithIdentifier:(NSString *)identifier;
+ (NSString *)filePathWithEmail:(NSString *)email name:(NSString *)name;
//+ (NSArray<UIThemeModel *> *)getAllDownloadedThemes;

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
- (NSMutableDictionary *)dictionaryWithModel;

@end

@interface UIThemeFontModel : NSObject

/**
 偏好的字号，默认值为系统建议字号：14。
 当此数值变更时，custom的字号以相同的比例变更。
 */
@property (assign, nonatomic) CGFloat prefersFontSize;


/**
 字体名（为空时是系统字体）
 */
@property (copy, nonatomic) NSString *name;

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
- (NSMutableDictionary *)dictionaryWithModel;

@end

@interface UIThemeIconModel : NSObject

// @xaoxuu: json dictionary
@property (strong, nonatomic) NSDictionary *dict;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;
- (NSMutableDictionary *)dictionaryWithModel;

@end

@interface UIThemeInfoModel : NSObject


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
 theme's price
 */
@property (assign, nonatomic) CGFloat price;


/**
 theme's preview image urls
 */
@property (copy, nonatomic) NSArray<NSString *> *preview;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;
- (NSMutableDictionary *)dictionaryWithModel;

@end
