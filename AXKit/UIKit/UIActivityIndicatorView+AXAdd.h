//
//  UIActivityIndicatorView+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIActivityIndicatorView (AXWrapper)


/**
 创建一个活动指示器

 @return 活动指示器
 */
+ (instancetype)defaultIndicator;


/**
 创建一个带"LOADING"字样的活动指示器

 @return 一个带"LOADING"字样的活动指示器
 */
+ (instancetype)defaultIndicatorWithLoading;


/**
 显示到某个view

 @param view view
 */
- (void)addToView:(UIView *)view;

/**
 显示到某个view (带"LOADING"字样的活动指示器)

 @param view view
 @param loading "LOADING"标签
 */
- (void)addToView:(UIView *)view withLoading:(BOOL)loading;


@end
