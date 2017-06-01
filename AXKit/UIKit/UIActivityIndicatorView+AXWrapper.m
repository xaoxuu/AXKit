//
//  UIActivityIndicatorView+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIActivityIndicatorView+AXWrapper.h"
#import "CoreGraphics+AXExtension.h"
#import "UIView+AXFrameWrapper.h"
#import "NSOperation+AXExtension.h"

@interface UIActivityIndicatorView ()

// @xaoxuu: 是否带loading
@property (assign, nonatomic) BOOL withLoading;

@end

@implementation UIActivityIndicatorView (AXWrapper)

+ (instancetype)defaultIndicator{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.hidesWhenStopped = YES;
    indicator.withLoading = NO;
    return indicator;
}

+ (instancetype)defaultIndicatorWithLoading{
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.hidesWhenStopped = YES;
    // @xaoxuu: loading label
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5*kScreenW, 16)];
    lb.font = [UIFont systemFontOfSize:11];
    lb.textColor = [UIColor lightGrayColor];
    lb.text = @"LOADING";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.top = indicator.height + 4;
    lb.centerX = 0.5*indicator.width;
    [indicator addSubview:lb];
    indicator.withLoading = YES;
    return indicator;
}


- (UIActivityIndicatorView *(^)(CGFloat y))y{
    return ^(CGFloat y){
        UIView *su = self.superview;
        self.centerY = 0.5*su.height;
        return self;
    };
}

- (UIActivityIndicatorView *(^)(UIView *view))layoutToView{
    return ^(UIView *view){
        if (self.withLoading) {
            self.center = CGPointMake(0.5*view.width, 0.5*view.height - 8);
        } else {
            self.center = CGPointMake(0.5*view.width, 0.5*view.height);
        }
        
        [view addSubview:self];
        return self;
    };
}


- (UIActivityIndicatorView *(^)(UIView *view))show{
    return ^(UIView *view){
        
        if (self.withLoading) {
            self.center = CGPointMake(0.5*view.width, 0.5*view.height - 8);
        } else {
            self.center = CGPointMake(0.5*view.width, 0.5*view.height);
        }
        [view addSubview:self];
        [self startAnimating];
        [NSBlockOperation ax_delay:20 performInMainQueue:^{
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
