//
//  UIImageView+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 27/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 根据image名创建一个imgage view

 @param name image名
 @return image view
 */
CG_EXTERN UIImageView *UIImageViewWithImageNamed(NSString *name);

@interface UIImageView (AXAdd)

+ (UIImageView *(^)(NSString *))initWithImageName;

+ (UIImageView *(^)(UIImage *))initWithImage;

+ (UIImageView *(^)(CGRect))initWithFrame;


@end
