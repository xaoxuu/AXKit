//
//  UIScreen+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 07/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIScreen+AXExtension.h"

@implementation UIScreen (AXExtension)

+ (UIScreenSize)screenSize{
    static UIScreenSize currentSize;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize size = [UIScreen mainScreen].currentMode.size;
        if (CGSizeEqualToSize(size, CGSizeMake(320, 480)) || CGSizeEqualToSize(size, CGSizeMake(640, 960))) {
            currentSize = UIScreenSize_3_5;
        } else if (CGSizeEqualToSize(size, CGSizeMake(640, 1136))) {
            currentSize = UIScreenSize_4_0;
        } else if (CGSizeEqualToSize(size, CGSizeMake(750, 1334))) {
            currentSize = UIScreenSize_4_7;
        } else if (CGSizeEqualToSize(size, CGSizeMake(1242, 2208))) {
            currentSize = UIScreenSize_5_5;
        } else if (CGSizeEqualToSize(size, CGSizeMake(1125, 2436))) {
            currentSize = UIScreenSize_5_8;
        } else {
            currentSize = UIScreenSizeUnknown;
        }
    });
    return currentSize;
}

@end
