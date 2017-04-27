//
//  UIImageView+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 27/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIImageView+AXExtension.h"
#import "UIImage+AXExtension.h"

@implementation UIImageView (AXExtension)

- (void)ax_fillWithColor:(UIColor *)color{
    self.image = [UIImage ax_imageWithColor:color size:self.frame.size alpha:1];
}

@end
