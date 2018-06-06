//
//  UIImageView+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 27/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIImageView+AXAdd.h"
#import "UIImage+AXAdd.h"



inline UIImageView *UIImageViewWithImageNamed(NSString *name){
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
}


@implementation UIImageView (AXAdd)

+ (UIImageView * _Nonnull (^)(NSString * _Nonnull))named{
    return ^UIImageView *(NSString *name){
        return UIImageViewWithImageNamed(name);
    };
}


@end
