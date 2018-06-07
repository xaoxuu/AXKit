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

@end

