//
//  BaseLabel.m
//  AXKit
//
//  Created by xaoxuu on 20/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseLabel.h"

static const CGFloat lbHeight = 20;

@interface BaseLabel ()


@end

@implementation BaseLabel

+ (instancetype)labelWithTitle:(NSString *)title fontSize:(CGFloat)fontSize{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, kScreenW, lbHeight) title:title fontSize:fontSize];
}

+ (instancetype)labelWithTitle:(NSString *)title{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, kScreenW, lbHeight) title:title];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title fontSize:(CGFloat)fontSize{
    if (self = [self initWithFrame:frame title:title]) {
        self.font = [UIFont systemFontOfSize:fontSize?:14];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    if (self = [self initWithFrame:frame]) {
        self.text = title;
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _base_setupUI];
    }
    return self;
}


- (void)_base_setupUI{
    self.textAlignment = NSTextAlignmentCenter;
    if ([self respondsToSelector:@selector(setupUI)]) {
        [self setupUI];
    }
}



- (void)setText:(NSString *)text{
    [super setText:text];
    [self sizeToFit];
}

- (void)setupUI{
    
}


@end
