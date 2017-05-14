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
    indicator.center = CGPointMake(0.5*view.width, 0.5*view.height);
    [indicator startAnimating];
    return indicator;
}



@end
