//
//  UINavigationItem+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 14/07/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UINavigationItem+AXExtension.h"

@implementation UINavigationItem (AXExtension)

- (void)ax_hideBackBarButtonItem{
    self.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

@end
