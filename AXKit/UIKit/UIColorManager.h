//
//  UIColorManager.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIColorManager;
extern UIColorManager *axColor;

@interface UIColorManager : NSObject

#pragma mark - 主题色


/**
 当前app的主题色
 */
@property (strong, nonatomic) UIColor *theme;


/**
 当前app的强调色
 */
@property (strong, nonatomic) UIColor *accent;


/**
 当前app的背景色（一般为白色或很浅的灰色）
 */
@property (strong, nonatomic) UIColor *background;


#pragma mark - 颜色工具

/**
 保存颜色配置文件
 */
- (void)saveCurrentColorProfiles;

/**
 保存颜色配置文件（在appDelegate中配置一次即可）

 @param theme 主题色
 @param accent 强调色
 @param background 背景色
 */
- (void)saveColorProfilesWithTheme:(UIColor *)theme accent:(UIColor *)accent background:(UIColor *)background;

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

@end


