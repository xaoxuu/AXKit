//
//  UIFont+AXWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 创建字体

 @param size 字号
 @return 字体实例
 */
UIKIT_EXTERN UIFont *FontWithSize(CGFloat size);

/**
 创建加粗字体

 @param size 字号
 @return 字体实例
 */
UIKIT_EXTERN UIFont *BoldFontWithSize(CGFloat size);

/**
 获取文本框高度

 @param text 文本内容
 @param font 字体
 @param width 文本框宽度
 @return 文本框高度
 */
UIKIT_EXTERN CGFloat HeightWithTextFontWidth(NSString *text,UIFont *font,CGFloat width);

@interface UIFont (AXWrapper)

@end
