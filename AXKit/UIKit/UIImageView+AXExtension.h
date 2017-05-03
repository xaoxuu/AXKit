//
//  UIImageView+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 27/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AXExtension)


/**
 填充颜色

 @param color 颜色
 */
- (void)ax_fillWithColor:(UIColor *)color;

/**
 填充随机色（多用于项目初期）
 */
- (void)ax_fillWithRandomColor;

@end