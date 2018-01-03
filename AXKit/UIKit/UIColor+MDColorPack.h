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
@property (class, strong, readonly, nonatomic) UIColor *md_red;
@property (class, strong, readonly, nonatomic) UIColor *md_pink;
@property (class, strong, readonly, nonatomic) UIColor *md_purple;
@property (class, strong, readonly, nonatomic) UIColor *md_deepPurple;

#pragma mark blue -> cyan
@property (class, strong, readonly, nonatomic) UIColor *md_indigo;
@property (class, strong, readonly, nonatomic) UIColor *md_blue;
@property (class, strong, readonly, nonatomic) UIColor *md_lightBlue;
@property (class, strong, readonly, nonatomic) UIColor *md_cyan;
@property (class, strong, readonly, nonatomic) UIColor *md_teal;

#pragma mark green -> yellow
@property (class, strong, readonly, nonatomic) UIColor *md_green;
@property (class, strong, readonly, nonatomic) UIColor *md_lightGreen;
@property (class, strong, readonly, nonatomic) UIColor *md_lime;
@property (class, strong, readonly, nonatomic) UIColor *md_yellow;
@property (class, strong, readonly, nonatomic) UIColor *md_amber;

#pragma mark orange -> gray
@property (class, strong, readonly, nonatomic) UIColor *md_orange;
@property (class, strong, readonly, nonatomic) UIColor *md_deepOrange;
@property (class, strong, readonly, nonatomic) UIColor *md_brown;
@property (class, strong, readonly, nonatomic) UIColor *md_blueGray;
@property (class, strong, readonly, nonatomic) UIColor *md_gray;


@end
