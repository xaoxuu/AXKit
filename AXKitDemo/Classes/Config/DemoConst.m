//
//  DemoConst.m
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DemoConst.h"



const CGFloat kStatusBarHeight = 20;

const CGFloat kNavBarHeight = 44;

const CGFloat kTabBarHeight = 49;

const CGFloat kMargin4 = 4;

const CGFloat kMarginNormal = 8;

const CGFloat kMargin12 = 12;

const CGFloat kMargin16 = 16;

const CGFloat kButtonHeight = 46;


inline UIFont *kFontNormal(){
    return [UIFont systemFontOfSize:14];
}


// @xaoxuu: 重载冷却（1秒内最多加载一次数据）
NSTimeInterval reloadCooldown = 1;
NSString *reloadToken = @"reloadCooldown";
// @xaoxuu: 刷新按钮的冷却（2秒内最多接受一次点击）
NSTimeInterval reloadBtnCooldown = 2;
NSString *reloadBtnToken = @"reloadBtnCooldown";


@implementation DemoConst

@end
