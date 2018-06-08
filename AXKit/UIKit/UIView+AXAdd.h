//
//  UIView+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreGraphics+AXAdd.h"
#import "UIView+AXFrameAdd.h"


NS_ASSUME_NONNULL_BEGIN

@interface UIView (AXAdd)

/**
 从xib加载view
 
 @return view
 */
+ (__kindof UIView *(^)(NSString *))initWithNibName;

/**
 创建一个指定高的view
 */
+ (__kindof UIView *(^)(CGFloat height))initWithHeight;

/**
 创建一个指定size的view
 */
+ (__kindof UIView *(^)(CGSize size))initWithSize;

/**
 获取view
 */
- (UIImage *(^)(void))screenshot;

/**
 对view的layer进行若干操作

 @param layer layer
 */
- (void)ax_layer:(void (^)(CALayer *layer))layer;

/**
 移除所有子视图

 @param subClass 指定范围（只移除属于哪个类的子视图，传入nil时移除所有子视图）
 */
- (void)ax_removeAllSubviews:(nullable Class)subClass;

/**
 让每个子视图执行一段代码

 @param subClass 指定范围（属于哪个类的子视图，传入nil时代表所有子视图）
 @param action   子视图所执行的代码块
 */
- (void)ax_allSubviews:(nullable Class)subClass action:(void (^)(__kindof UIView *subview))action;


/**
 让每个UILabel执行一段代码

 @param action 要执行的代码
 */
- (void)ax_allLabelsInvokeAction:(void (^)(__kindof UILabel *label))action;

/**
 让每个UITextField执行一段代码
 
 @param action 要执行的代码
 */
- (void)ax_allTextFieldsInvokeAction:(void (^)(__kindof UITextField *textField))action;

/**
 让每个UITextView执行一段代码
 
 @param action 要执行的代码
 */
- (void)ax_allTextViewsInvokeAction:(void (^)(__kindof UITextView *textView))action;

/**
 让每个UIButton执行一段代码
 
 @param action 要执行的代码
 */
- (void)ax_allButtonsInvokeAction:(void (^)(__kindof UIButton *button))action;

/**
 让每个UIImageView执行一段代码
 
 @param action 要执行的代码
 */
- (void)ax_allImageViewsInvokeAction:(void (^)(__kindof UIImageView *imageView))action;

/**
 让每个tag在指定范围的子视图执行一段代码

 @param tagRange 指定tag取值范围
 @param action 要执行的代码
 */
- (void)ax_allSubviewsWithTagsInRange:(AXIntegerRange)tagRange action:(void (^)(__kindof UIView *subview))action;

/**
 让每个tag等于某个值的子视图执行一段代码
 
 @param tag 指定tag值
 @param action 要执行的代码
 */
- (void)ax_allSubviewsWithTag:(NSInteger)tag action:(void (^)(__kindof UIView *subview))action;

/**
 view在screen中的frame

 @return view在screen中的frame
 */
- (CGRect)frameInScreen;

@end

NS_ASSUME_NONNULL_END
