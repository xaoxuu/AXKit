//
//  CoreGraphics+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CoreGraphics+AXExtension.h"


#pragma mark - 常量

const CGFloat kStatusBarHeight = 20;
const CGFloat kNavBarHeight = 44;
const CGFloat kTopBarHeight = 64;
const CGFloat kTabBarHeight = 49;

const CGFloat kMarginNarrow = 4;
const CGFloat kMarginNormal = 8;
const CGFloat kMarginWide = 16;





inline CGRect CGRectFromScreen(){
    return [UIScreen mainScreen].bounds;
}


inline CGSize CGSizeUp(CGFloat upOffset){
    return CGSizeMake(0, -upOffset);
}

inline CGSize CGSizeDown(CGFloat downOffset){
    return CGSizeMake(0, downOffset);
}


inline CGRect CGRectWithTopMargin(CGFloat top){
    return CGRectMake(0, top, kScreenW, kScreenH-top);
}
inline CGRect CGRectWithTopAndBottomMargin(CGFloat top, CGFloat bottom){
    return CGRectMake(0, top, kScreenW, kScreenH-top-bottom);
}
