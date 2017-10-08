//
//  BaseButton.h
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseButton : UIButton

+ (instancetype)buttonWithTitle:(NSString *)title;

+ (instancetype)buttonWithTitle:(NSString *)title action:(void (^)(__kindof BaseButton *sender))action;

- (void)addToView:(UIView *)view withTop:(CGFloat)top;

- (void)addToView:(UIView *)view withBottom:(CGFloat)bottom;

- (void)setupButton;


- (__kindof BaseButton *(^)(UIView *view))addToView;

- (__kindof BaseButton *(^)(void))layoutToTop;

- (__kindof BaseButton *(^)(void))layoutToBottom;


@end
