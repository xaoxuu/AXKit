//
//  UINavigationBar+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UINavigationBar+AXAdd.h"
#import "UIView+AXAdd.h"

@implementation UINavigationBar (AXExtension)


- (void)ax_hideSeparator{
    [self ax_allSubviews:[NSClassFromString(@"UIBarBackground") class] action:^(__kindof UIView * _Nonnull subview) {
        [subview ax_allImageViewsInvokeAction:^(__kindof UIImageView * _Nonnull imageView) {
            if (imageView.frame.size.height < 1) {
                imageView.hidden = YES;
            }
        }];
    }];
}

@end
