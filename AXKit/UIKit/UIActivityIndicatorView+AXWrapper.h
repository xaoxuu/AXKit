//
//  UIActivityIndicatorView+AXWrapper.h
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIActivityIndicatorView (AXWrapper)

+ (instancetype)defaultIndicator;

/**
 放置到view
 */
- (UIActivityIndicatorView *(^)(UIView *view))layoutToView;



/**
 纵坐标
 */
- (UIActivityIndicatorView *(^)(CGFloat y))y;



/**
 显示
 */
- (UIActivityIndicatorView *(^)(UIView *view))show;

/**
 隐藏
 */
- (UIActivityIndicatorView *(^)())hide;





@end
