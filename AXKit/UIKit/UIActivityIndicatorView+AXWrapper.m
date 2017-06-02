//
//  UIActivityIndicatorView+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIActivityIndicatorView+AXWrapper.h"
#import "CoreGraphics+AXExtension.h"
#import "UIView+AXFrameExtension.h"
#import "NSOperation+AXExtension.h"

static NSTimeInterval indicatorTimeout = 30;

@implementation UIActivityIndicatorView (AXWrapper)

+ (instancetype)defaultIndicator{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.hidesWhenStopped = YES;
    return indicator;
}

+ (instancetype)defaultIndicatorWithLoading{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.hidesWhenStopped = YES;
    // @xaoxuu: loading label
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5*kScreenW, 16)];
    lb.font = [UIFont systemFontOfSize:11];
    lb.textColor = [UIColor lightGrayColor];
    lb.text = NSLocalizedString(@"LOADING", nil);
    lb.textAlignment = NSTextAlignmentCenter;
    lb.top = indicator.height + 4;
    lb.centerX = indicator.boundsCenterX;
    [indicator addSubview:lb];
    return indicator;
}


- (void)addToView:(UIView *)view{
    [self addToView:view withLoading:NO];
}

- (void)addToView:(UIView *)view withLoading:(BOOL)loading{
    self.centerX = view.boundsCenterX;
    if (loading) {
        self.centerY = view.boundsCenterY - 8;
    } else {
        self.centerY = view.boundsCenterY;
    }
    [view addSubview:self];
    [self startAnimating];
    [NSBlockOperation ax_delay:indicatorTimeout performInMainQueue:^{
        [self stopAnimating];
    }];
}



@end
