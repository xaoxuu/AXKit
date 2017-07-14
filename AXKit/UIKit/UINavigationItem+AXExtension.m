//
//  UINavigationItem+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 14/07/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UINavigationItem+AXExtension.h"

@implementation UINavigationItem (AXExtension)

/**
 隐藏返回按钮的标题
 */
- (void)ax_hideBackBarButtonTitle{
    self.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}


/**
 隐藏返回按钮（同时也不能右划返回）
 */
- (void)ax_hideBackBarButton{
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}


@end
