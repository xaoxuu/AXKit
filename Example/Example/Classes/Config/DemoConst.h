//
//  DemoConst.h
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//// @xaoxuu: 状态栏高度
//CG_EXTERN const CGFloat kStatusBarHeight;
//// @xaoxuu: 导航栏高度
//CG_EXTERN const CGFloat kNavBarHeight;
//// @xaoxuu: tabbar高度
//CG_EXTERN const CGFloat kTabBarHeight;


// @xaoxuu: 窄 margin = 4
CG_EXTERN const CGFloat kMargin4;
// @xaoxuu: 普通 margin = 8
CG_EXTERN const CGFloat kMarginNormal;
// @xaoxuu: 宽 margin = 12
CG_EXTERN const CGFloat kMargin12;
// @xaoxuu: 很宽 margin = 16
CG_EXTERN const CGFloat kMargin16;


// @xaoxuu: 按钮高度
CG_EXTERN const CGFloat kButtonHeight;


CG_EXTERN UIFont *kFontNormal(void);

// @xaoxuu: 重载冷却（1秒内最多加载一次数据）
CG_EXTERN NSTimeInterval reloadCooldown;
// @xaoxuu: 重载计时id（id相同则共享冷却时间）
FOUNDATION_EXTERN NSString *reloadToken;

// @xaoxuu: 刷新按钮的冷却（1秒内最多接受一次点击）
CG_EXTERN NSTimeInterval reloadBtnCooldown;
// @xaoxuu: 重载计时id（id相同则共享冷却时间）
FOUNDATION_EXTERN NSString *reloadBtnToken;



@interface DemoConst : NSObject

@end
