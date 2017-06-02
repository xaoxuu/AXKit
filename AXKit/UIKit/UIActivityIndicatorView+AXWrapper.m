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

static NSTimeInterval indicatorTimeout = 20;

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
    lb.frameCenterX = indicator.boundsCenterX;
    [indicator addSubview:lb];
    return indicator;
}


- (UIActivityIndicatorView *(^)(CGFloat y))y{
    return ^(CGFloat y){
        UIView *su = self.superview;
        self.frameCenterY = su.boundsCenterY;
        return self;
    };
}

- (UIActivityIndicatorView *(^)(UIView *view))layoutToView{
    return ^(UIView *view){
        self.center = CGPointWithCenterOfView(view);
        [view addSubview:self];
        return self;
    };
}


- (UIActivityIndicatorView *(^)(UIView *view))show{
    return ^(UIView *view){
        self.center = CGPointWithCenterOfView(view);
        [view addSubview:self];
        [self startAnimating];
        [NSBlockOperation ax_delay:indicatorTimeout performInMainQueue:^{
            [self stopAnimating];
        }];
        return self;
    };
}

- (UIActivityIndicatorView *(^)())hide{
    return ^{
        if (self.isAnimating) {
            [self stopAnimating];
        }
        return self;
    };
}



@end
