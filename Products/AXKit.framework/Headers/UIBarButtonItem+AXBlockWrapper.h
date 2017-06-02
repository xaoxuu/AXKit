//
//  UIBarButtonItem+AXBlockWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foundation+AXMacros.h"

NS_ASSUME_NONNULL_BEGIN


@interface UIBarButtonItem (ATBlockWrapper)

#pragma mark - 静态构造方法

#pragma mark 推荐

/**
 创建一个baritem
 
 @param image 图片名
 @param action 响应的事件
 @return baritem实例
 */
+ (instancetype)ax_itemWithImageName:(NSString *)image action:(void (^)(UIBarButtonItem *sender))action;

/**
 快速创建一个baritem
 
 @param title 标题
 @param action 响应的事件
 @return baritem实例
 */
+ (instancetype)ax_itemWithTitle:(NSString *)title action:(void (^)(UIBarButtonItem *sender))action;

/**
 快速创建一个baritem
 
 @param view 自定义视图
 @param action 响应的事件
 @return baritem实例
 */
+ (instancetype)ax_itemWithCustomView:(UIView *)view action:(void (^)(UIBarButtonItem *sender))action;


#pragma mark 普通

/**
 创建一个system样式的baritem
 
 @param systemItem 系统item样式
 @param action 响应的事件
 @return item实例
 */
+ (instancetype)ax_itemWithSystem:(UIBarButtonSystemItem)systemItem action:(void (^)(UIBarButtonItem *sender))action;



/**
 创建一个自定义baritem
 
 @param image 图片
 @param style 样式
 @param action 响应的事件
 @return item实例
 */
+ (instancetype)ax_itemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action;

/**
 创建一个自定义baritem
 
 @param image 图片
 @param landscapeImagePhone 横屏图片
 @param style 样式
 @param action 响应的事件
 @return item实例
 */
+ (instancetype)ax_itemWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action;


/**
 创建一个文字baritem
 
 @param title 文字
 @param style 样式
 @param action 响应的事件
 @return item实例
 */
+ (instancetype)ax_itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action;

#pragma mark - 实例构造方法

/**
 创建一个system样式的baritem
 
 @param systemItem 系统item样式
 @param action 响应的事件
 @return item实例
 */
- (instancetype)ax_initWithSystem:(UIBarButtonSystemItem)systemItem action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER;


/**
 创建一个自定义baritem
 
 @param image 图片
 @param style 样式
 @param action 响应的事件
 @return item实例
 */
- (instancetype)ax_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER;

/**
 创建一个自定义baritem
 
 @param image 图片
 @param landscapeImagePhone 横屏图片
 @param style 样式
 @param action 响应的事件
 @return item实例
 */
- (instancetype)ax_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER;

/**
 创建一个文字baritem
 
 @param title 文字
 @param style 样式
 @param action 响应的事件
 @return item实例
 */
- (instancetype)ax_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER;

/**
 快速创建一个baritem
 
 @param view 自定义视图
 @param action 响应的事件
 @return baritem实例
 */
- (instancetype)ax_initWithCustomView:(UIView *)view action:(void (^)(UIBarButtonItem *sender))action AX_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
