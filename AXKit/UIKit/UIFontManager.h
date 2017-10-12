//
//  UIFontManager.h
//  AXKit
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class UIFontManager;
extern UIFontManager *axFont;


#define NOTI_FONT_SIZE_CHANGED @"NOTI_FONT_SIZE_CHANGED"

@interface UIFontManager : NSObject


/**
 偏好的字号，默认值为系统建议字号：14。当此数值变更时，custom的字号以相同的比例变更。
 */
@property (assign, nonatomic) CGFloat prefersFontSize;



// @xaoxuu: system small = 12
@property (strong, readonly, nonatomic) UIFont *systemSmall;
// @xaoxuu: system normal = 14
@property (strong, readonly, nonatomic) UIFont *systemNormal;



// @xaoxuu: normal
@property (strong, readonly, nonatomic) UIFont *customSmall;
@property (strong, readonly, nonatomic) UIFont *customBoldSmall;
// @xaoxuu: normal
@property (strong, readonly, nonatomic) UIFont *customNormal;
@property (strong, readonly, nonatomic) UIFont *customBoldNormal;
// @xaoxuu: normal
@property (strong, readonly, nonatomic) UIFont *customLarge;
@property (strong, readonly, nonatomic) UIFont *customBoldLarge;


- (UIFont *)fontWithCustomPrefersFontSize:(CGFloat)size;
- (UIFont *)boldFontWithCustomPrefersFontSize:(CGFloat)size;

#pragma mark - life circle

+ (instancetype)defaultManager;

+ (instancetype)sharedInstance;


@end
NS_ASSUME_NONNULL_END
