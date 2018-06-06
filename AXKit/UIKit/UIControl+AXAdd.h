//
//  UIControl+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - UIControl
@interface UIControl (AXAdd)

/**
 添加一个事件

 @param handler 处理事件的block
 @param controlEvents 事件
 */
- (void)ax_addEventHandler:(void (^)(__kindof UIControl *sender))handler forControlEvents:(UIControlEvents)controlEvents;

/**
 移除一个事件

 @param controlEvents 事件
 */
- (void)ax_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end

#pragma mark - UIButton
@interface UIButton (AXAdd)

/**
 添加一个事件

 @param handler       处理事件的block
 @param controlEvents 事件
 */
- (void)ax_addEventHandler:(void (^)(__kindof UIButton *sender))handler forControlEvents:(UIControlEvents)controlEvents;

/**
 添加一个TouchDown事件
 
 @param handler       处理事件的block
 */
- (void)ax_addTouchDownHandler:(void (^)(__kindof UIButton *sender))handler;

/**
 添加一个TouchUpInside事件
 
 @param handler       处理事件的block
 */
- (void)ax_addTouchUpInsideHandler:(void (^)(__kindof UIButton *sender))handler;


@end

#pragma mark - UISlider
@interface UISlider (AXAdd)

/**
 添加一个任意事件
 
 @param handler       处理事件的block
 @param controlEvents 事件
 */
- (void)ax_addEventHandler:(void (^)(__kindof UISlider *sender))handler forControlEvents:(UIControlEvents)controlEvents;

/**
 添加一个TouchDown事件
 
 @param handler       处理事件的block
 */
- (void)ax_addTouchDownHandler:(void (^)(__kindof UISlider *sender))handler;

/**
 添加一个ValueChanged事件

 @param handler 处理事件的block
 */
- (void)ax_addValueChangedHandler:(void (^)(__kindof UISlider *sender))handler;

/**
 添加一个TouchUp事件
 
 @param handler       处理事件的block
 */
- (void)ax_addTouchUpHandler:(void (^)(__kindof UISlider *sender))handler;


@end

#pragma mark - UISwitch
@interface UISwitch (AXAdd)

/**
 添加一个任意事件
 
 @param handler       处理事件的block
 @param controlEvents 事件
 */
- (void)ax_addEventHandler:(void (^)(__kindof UISwitch *sender))handler forControlEvents:(UIControlEvents)controlEvents;

/**
 添加一个TouchDown事件
 
 @param handler       处理事件的block
 */
- (void)ax_addTouchDownHandler:(void (^)(__kindof UISwitch *sender))handler;

/**
 添加一个ValueChanged事件
 
 @param handler       处理事件的block
 */
- (void)ax_addValueChangedHandler:(void (^)(__kindof UISwitch *sender))handler;

/**
 添加一个TouchUp事件
 
 @param handler       处理事件的block
 */
- (void)ax_addTouchUpInsideHandler:(void (^)(__kindof UISwitch *sender))handler;

@end

#pragma mark - UISegmentedControl
@interface UISegmentedControl (AXAdd)

/**
 添加一个任意事件
 
 @param handler       处理事件的block
 @param controlEvents 事件
 */
- (void)ax_addEventHandler:(void (^)(__kindof UISegmentedControl *sender))handler forControlEvents:(UIControlEvents)controlEvents;

/**
 添加一个ValueChanged事件
 
 @param handler       处理事件的block
 */
- (void)ax_addValueChangedHandler:(void (^)(__kindof UISegmentedControl *sender))handler;


@end

#pragma mark - UITextField
@interface UITextField (AXAdd)

/**
 添加一个任意事件
 
 @param handler       处理事件的block
 @param controlEvents 事件
 */
- (void)ax_addEventHandler:(void (^)(__kindof UITextField *sender))handler forControlEvents:(UIControlEvents)controlEvents;

/**
 添加一个EditingBegin事件
 
 @param handler       处理事件的block
 */
- (void)ax_addEditingBeginHandler:(void (^)(__kindof UITextField *sender))handler;

/**
 添加一个EditingChanged事件
 
 @param handler       处理事件的block
 */
- (void)ax_addEditingChangedHandler:(void (^)(__kindof UITextField *sender))handler;

/**
 添加一个EditingEndOnExit事件
 
 @param handler       处理事件的block
 */
- (void)ax_addEditingEndOnExitHandler:(void (^)(__kindof UITextField *sender))handler;

/**
 添加一个EditingEnd事件
 
 @param handler       处理事件的block
 */
- (void)ax_addEditingEndHandler:(void (^)(__kindof UITextField *sender))handler;

@end


NS_ASSUME_NONNULL_END

