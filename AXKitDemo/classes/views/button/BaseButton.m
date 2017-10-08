//
//  BaseButton.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton



- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupButton];
}

- (void)setupButton{
    
}



+ (instancetype)buttonWithTitle:(NSString *)title{
    BaseButton *btn = [self buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

+ (instancetype)buttonWithTitle:(NSString *)title action:(void (^)(__kindof BaseButton *sender))action{
    BaseButton *btn = [self buttonWithTitle:title];
    [btn ax_addTouchUpInsideHandler:action];
    return btn;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupButton];
    }
    return self;
}

- (void)addToView:(UIView *)view withTop:(CGFloat)top{
    [view addSubview:self];
    self.top = top;
}

- (void)addToView:(UIView *)view withBottom:(CGFloat)bottom{
    [view addSubview:self];
    self.bottom = view.height - bottom;
    
}


- (__kindof BaseButton *(^)(UIView *view))addToView{
    return ^(UIView *view){
        [view addSubview:self];
        return self;
    };
}

- (__kindof BaseButton *(^)(void))layoutToTop{
    return ^{
        self.top = 16;
        return self;
    };
    
}

- (__kindof BaseButton *(^)(void))layoutToBottom{
    return ^{
        self.bottom = self.superview.height;
        [self.layer ax_shadow:LayerShadowUpLight];
        return self;
    };
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
}


@end
