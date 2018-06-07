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

+ (UIImageView * _Nonnull (^)(NSString * _Nonnull))initWithImageName{
    return ^UIImageView *(NSString *name){
        return UIImageViewWithImageNamed(name);
    };
}
+ (UIImageView *(^)(UIImage *))initWithImage{
    return ^UIImageView *(UIImage *image){
        return [UIImageView.alloc initWithImage:image];
    };
}
+ (UIImageView *(^)(CGRect))initWithFrame;{
    return ^UIImageView *(CGRect frame){
        return [UIImageView.alloc initWithFrame:frame];
    };
}

@end
