//
//  UIColor+MDColorPack.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//
// @xaoxuu: 此分类的颜色取自Google Material Design
// @xaoxuu: Material Design配色网站: http://www.materialpalette.com

#import <UIKit/UIKit.h>

@interface UIColor (MDColorPack)

#pragma mark red -> purple
+ (UIColor *)md_red;
+ (UIColor *)md_pink;
+ (UIColor *)md_purple;
+ (UIColor *)md_deepPurple;

#pragma mark blue -> cyan
+ (UIColor *)md_indigo;
+ (UIColor *)md_blue;
+ (UIColor *)md_lightBlue;
+ (UIColor *)md_cyan;
+ (UIColor *)md_teal;

#pragma mark green -> yellow
+ (UIColor *)md_green;
+ (UIColor *)md_lightGreen;
+ (UIColor *)md_lime;
+ (UIColor *)md_yellow;
+ (UIColor *)md_amber;

#pragma mark orange -> gray
+ (UIColor *)md_orange;
+ (UIColor *)md_deepOrange;
+ (UIColor *)md_brown;
+ (UIColor *)md_blueGray;
+ (UIColor *)md_gray;


@end
