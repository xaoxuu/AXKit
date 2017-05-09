//
//  UINavigationBar+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UINavigationBar+AXExtension.h"
#import "UIView+AXExtension.h"

@implementation UINavigationBar (AXExtension)


- (void)ax_removeSeparator{
    [self ax_eachSubview:[NSClassFromString(@"UIBarBackground") class] action:^(__kindof UIView * _Nonnull subview) {
        [subview ax_eachImageViewInvokeAction:^(__kindof UIImageView * _Nonnull imageView) {
            imageView.hidden = YES;
        }];
    }];
}

@end
