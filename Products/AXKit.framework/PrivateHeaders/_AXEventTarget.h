//
//  Foundation+AXEventTarget.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AXEventTarget : NSObject

// @xaoxuu: 事件处理器target
@property (copy, nonatomic) void (^handler)(id sender);

// @xaoxuu: 动画的view
@property (strong, nonatomic) UIView *view;

// @xaoxuu: 动画的scale
@property (assign, nonatomic) CGFloat scale;

// @xaoxuu: 动画的duration
@property (assign, nonatomic) NSTimeInterval duration;

// @xaoxuu: 创建一个事件处理器target
+ (instancetype)targetWithHandler:(void (^)(id sender))handler;

// @xaoxuu: 设置view动画
- (void)setupAnimationWithView:(UIView *)view scale:(CGFloat)scale duration:(NSTimeInterval)duration;

// @xaoxuu: 执行事件
- (void)handleEvent:(id)sender;

@end


