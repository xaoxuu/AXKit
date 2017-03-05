//
//  UIFont+AXWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN UIFont *FontWithSize(CGFloat size);

UIKIT_EXTERN UIFont *BoldFontWithSize(CGFloat size);

UIKIT_EXTERN CGFloat HeightWithTextFontWidth(NSString *text,UIFont *font,CGFloat width);

@interface UIFont (AXWrapper)

@end
