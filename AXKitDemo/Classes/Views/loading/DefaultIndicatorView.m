//
//  DefaultIndicatorView.m
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DefaultIndicatorView.h"

@interface DefaultIndicatorView ()


@end

@implementation DefaultIndicatorView

+ (instancetype)defaultIndicatorAddToView:(UIView *)view{
    DefaultIndicatorView *indicator = [[DefaultIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [view addSubview:indicator];
    indicator.hidesWhenStopped = YES;
    indicator.center = CGPointMake(0.5*view.width, 0.5*view.height - 20);
    [indicator startAnimating];
    // @xaoxuu: loading
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5*kScreenW, 20)];
    lb.font = [UIFont systemFontOfSize:11];
    lb.textColor = [UIColor lightGrayColor];
    lb.text = @"LOADING";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.top = indicator.height + 4;
    lb.centerX = 0.5*indicator.width;
    [indicator addSubview:lb];
    return indicator;
}



@end
