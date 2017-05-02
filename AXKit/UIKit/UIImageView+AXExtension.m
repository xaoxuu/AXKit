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

- (void)ax_fillWithRandomColor{
    self.image = [UIImage ax_imageWithColor:[UIColor colorWithRed:(float)(arc4random()%256)/256 green:(float)(arc4random()%256)/256 blue:(float)(arc4random()%256)/256 alpha:1.0] size:self.frame.size alpha:1];
}

@end
