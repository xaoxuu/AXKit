//
//  UIActivityIndicatorView+AXWrapper.h
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
 放置到view（居中）
 */
- (UIActivityIndicatorView *(^)(UIView *view))layoutToView;

/**
 纵坐标
 */
- (UIActivityIndicatorView *(^)(CGFloat y))y;

/**
 显示（居中）
 */
- (UIActivityIndicatorView *(^)(UIView *view))show;

/**
 隐藏
 */
- (UIActivityIndicatorView *(^)())hide;





@end
