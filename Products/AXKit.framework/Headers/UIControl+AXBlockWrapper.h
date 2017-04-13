//
//  UIControl+AXBlockWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** Block control event handling for UIControl.
 
 Includes code by the following:
 
 - [Kevin O'Neill](https://github.com/kevinoneill)
 - [Zach Waldowski](https://github.com/zwaldowski)
 
 @warning UIControl is only available on a platform with UIKit.
 */
#pragma mark - UIControl
@interface UIControl (AXBlockWrapper)

///-----------------------------------
/// @name Block event handling
///-----------------------------------

/** Adds a block for a particular event to an internal dispatch table.
 
 @param handler A block representing an action message, with an argument for the sender.
 @param controlEvents A bitmask specifying the control events for which the action message is sent.
 @see removeEventHandlersForControlEvents:
 */
- (void)ax_addEventHandler:(void (^)(__kindof UIControl *sender))handler forControlEvents:(UIControlEvents)controlEvents;

/** Removes all control event blocks associated with the given mask of control
 * events.
 *
 * Do note that, like @c UIControl, this method will not decompose control
 * events; thus, only a handler matching an exact given bitmask will be removed.
 *
 * @param controlEvents A bitmask specifying the control events for which the block will be removed.
 * @see addEventHandler:forControlEvents:
 */
- (void)ax_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

/** Checks to see if the control has any blocks for a particular event combination.
 @param controlEvents A bitmask specifying the control events for which to check for blocks.
 @see addEventHandler:forControlEvents:
 @return Returns YES if there are blocks for these control events, NO otherwise.
 */
- (NSUInteger)ax_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end

#pragma mark - UIButton
@interface UIButton (AXBlockWrapper)

/**
 添加一个任意事件

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

/**
 添加一个TouchUpInside事件，并附加动画

 @param handler  处理事件的block
 @param scale    动画的缩放比例
 @param duration 动画持续时间
 */
- (void)ax_addTouchUpInsideHandler:(nullable void (^)(__kindof UIButton *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration;


@end

#pragma mark - UISlider
@interface UISlider (AXBlockWrapper)

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
 添加一个TouchDown事件，并附加动画
 
 @param handler  处理事件的block
 @param scale    动画的缩放比例
 @param duration 动画持续时间
 */
- (void)ax_addTouchDownHandler:(nullable void (^)(__kindof UISlider *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration;


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

/**
 添加一个TouchUp事件，并附加动画
 
 @param handler  处理事件的block
 @param scale    动画的缩放比例
 @param duration 动画持续时间
 */
- (void)ax_addTouchUpHandler:(nullable void (^)(__kindof UISlider *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration;


@end

#pragma mark - UISwitch
@interface UISwitch (AXBlockWrapper)

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
@interface UISegmentedControl (AXBlockWrapper)

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
@interface UITextField (AXBlockWrapper)

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
 添加一个EditingBegin事件，并附加动画
 
 @param handler  处理事件的block
 @param scale    动画的缩放比例
 @param duration 动画持续时间
 */
- (void)ax_addEditingBeginHandler:(nullable void (^)(__kindof UITextField *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration;

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

/**
 添加一个EditingEnd事件，并附加动画
 
 @param handler  处理事件的block
 @param scale    动画的缩放比例
 @param duration 动画持续时间
 */
- (void)ax_addEditingEndHandler:(nullable void (^)(__kindof UITextField *sender))handler animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration;


@end


NS_ASSUME_NONNULL_END

