//
//  UIColorManager.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class UIColorManager;
extern UIColorManager *axColor;

@interface UIColorManager : NSObject

#pragma mark - 主题色


/**
 当前app的主题色，set方法会做本地缓存
 */
@property (strong, readwrite, nonatomic) UIColor *theme;


/**
 当前app的强调色，set方法会做本地缓存
 */
@property (strong, readwrite, nonatomic) UIColor *accent;


/**
 当前app的背景色，set方法会做本地缓存（一般为白色或很浅的灰色）
 */
@property (strong, readwrite, nonatomic) UIColor *background;


#pragma mark - 颜色工具



/**
 设置默认的颜色配置（会被新的更改覆盖，一般用在appDelegate中）

 @param theme 主题色
 @param accent 强调色
 @param background 背景色
 */
- (void)setupDefaultColorConfigurationTheme:(nullable UIColor *(^)())theme accent:(nullable UIColor *(^)())accent background:(nullable UIColor *(^)())background;


#pragma mark - 系统颜色

- (UIColor *)black;      // 0.0 white
- (UIColor *)darkGray;   // 0.333 white
- (UIColor *)gray;       // 0.5 white
- (UIColor *)lightGray;  // 0.667 white
- (UIColor *)white;      // 1.0 white
- (UIColor *)clear;      // 0.0 white, 0.0 alpha
- (UIColor *)groupTableViewBackground;


#pragma mark - life circle

+ (instancetype)defaultManager;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
