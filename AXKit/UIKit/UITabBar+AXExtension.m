//
//  UITabBar+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UITabBar+AXExtension.h"
#import "UIView+AXExtension.h"

@implementation UITabBar (AXExtension)


- (void)ax_hideSeparator{
    [self ax_allSubview:[NSClassFromString(@"UIBarBackground") class] action:^(__kindof UIView * _Nonnull subview) {
        [subview ax_allImageViewInvokeAction:^(__kindof UIImageView * _Nonnull imageView) {
            if (imageView.frame.size.height < 1) {
                imageView.hidden = YES;
            }
        }];
    }];
}

@end
