//
//  UIColor+AXColorPack.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AXColorPack)


// MARK: - MaterialDesign 配色

@property (class, strong, readonly, nonatomic) UIColor *md_red;
@property (class, strong, readonly, nonatomic) UIColor *md_pink;
@property (class, strong, readonly, nonatomic) UIColor *md_purple;
@property (class, strong, readonly, nonatomic) UIColor *md_deepPurple;

@property (class, strong, readonly, nonatomic) UIColor *md_indigo;
@property (class, strong, readonly, nonatomic) UIColor *md_blue;
@property (class, strong, readonly, nonatomic) UIColor *md_lightBlue;
@property (class, strong, readonly, nonatomic) UIColor *md_cyan;
@property (class, strong, readonly, nonatomic) UIColor *md_teal;

@property (class, strong, readonly, nonatomic) UIColor *md_green;
@property (class, strong, readonly, nonatomic) UIColor *md_lightGreen;
@property (class, strong, readonly, nonatomic) UIColor *md_lime;
@property (class, strong, readonly, nonatomic) UIColor *md_yellow;
@property (class, strong, readonly, nonatomic) UIColor *md_amber;

@property (class, strong, readonly, nonatomic) UIColor *md_orange;
@property (class, strong, readonly, nonatomic) UIColor *md_deepOrange;
@property (class, strong, readonly, nonatomic) UIColor *md_brown;
@property (class, strong, readonly, nonatomic) UIColor *md_blueGray;
@property (class, strong, readonly, nonatomic) UIColor *md_gray;


// MARK: - macOS 配色

@property (class, strong, readonly, nonatomic) UIColor *mac_maximize;
@property (class, strong, readonly, nonatomic) UIColor *mac_minimize;
@property (class, strong, readonly, nonatomic) UIColor *mac_close;
@property (class, strong, readonly, nonatomic) UIColor *mac_finder;


// MARK: - xaoxuu 配色

@property (class, strong, readonly, nonatomic) UIColor *ax_lightRed;
@property (class, strong, readonly, nonatomic) UIColor *ax_red;
@property (class, strong, readonly, nonatomic) UIColor *ax_lightPurple;
@property (class, strong, readonly, nonatomic) UIColor *ax_blue;
@property (class, strong, readonly, nonatomic) UIColor *ax_cyan;
@property (class, strong, readonly, nonatomic) UIColor *ax_green;




@end
