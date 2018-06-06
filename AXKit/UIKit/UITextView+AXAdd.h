//
//  UITextView+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreGraphics+AXAdd.h"


@interface UITextView (AXAdd)


/**
 当键盘弹出的时候调整某个view的frame
 
 @param view 需要调整的view
 */
- (void)ax_adjustViewFrameWithKeyboard:(UIView *)view;


/**
 获取TextView的高度

 @param text TextView的文本
 @param range 高度范围（保证高度值不会超出此范围）
 @return 高度
 */
- (CGFloat)ax_heightWithText:(NSString *)text heightRange:(AXFloatRange)range;


@end

