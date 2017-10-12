//
//  UIFontManager.m
//  AXKit
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIFontManager.h"

UIFontManager *axFont = nil;

static CGFloat standardSize = 14.0f;
static CGFloat smallSize = 12.0f;

@implementation UIFontManager


- (void)setPrefersFontSize:(CGFloat)prefersFontSize{
    _prefersFontSize = prefersFontSize;
    
    CGFloat ratio = prefersFontSize / standardSize;
    
    _customSmall = [UIFont systemFontOfSize:smallSize * ratio];
    _customBoldSmall = [UIFont boldSystemFontOfSize:smallSize * ratio];
    _customNormal = [UIFont systemFontOfSize:standardSize * ratio];
    _customBoldNormal = [UIFont boldSystemFontOfSize:standardSize * ratio];
    _customLarge = [UIFont systemFontOfSize:standardSize * 1.2 * ratio];
    _customBoldLarge = [UIFont boldSystemFontOfSize:standardSize * 1.2 * ratio];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_FONT_SIZE_CHANGED object:@YES];
    
}


- (UIFont *)fontWithCustomPrefersFontSize:(CGFloat)size{
    CGFloat ratio = size / standardSize;
    return [UIFont systemFontOfSize:standardSize * ratio];
}
- (UIFont *)boldFontWithCustomPrefersFontSize:(CGFloat)size{
    CGFloat ratio = size / standardSize;
    return [UIFont boldSystemFontOfSize:standardSize * ratio];
}

#pragma mark - life circle

#pragma mark init
// init
- (instancetype)init{
    if (self = [super init]) {
        
    }
    
    // init
    CGFloat small = [UIFont smallSystemFontSize]; //12
    CGFloat standard = [UIFont systemFontSize]; //14
    
    _systemSmall = [UIFont systemFontOfSize:small];
    _systemNormal = [UIFont systemFontOfSize:standard];
    self.prefersFontSize = standard;
    
    return axFont;
    
}
#pragma mark creator

// defaultManager
+ (instancetype)defaultManager{
    return [self sharedInstance];
}

// sharedInstance
+ (instancetype)sharedInstance{
    if (!axFont) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!axFont) {
                axFont = [[self alloc] init];
            }
        });
    }
    return axFont;
}

// allocWithZone
+ (instancetype) allocWithZone:(NSZone *)zone{
    if (!axFont) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!axFont) {
                axFont = [super allocWithZone:zone];
            }
        });
    }
    return axFont;
}



// copyWithZone
+ (id)copyWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

// copyWithZone
- (id)copyWithZone:(struct _NSZone *)zone{
    return [UIFontManager sharedInstance];
}

// mutableCopyWithZone
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

// mutableCopyWithZone
- (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return [UIFontManager sharedInstance];
}

// copy
+ (id)copy{
    return [UIFontManager sharedInstance];
}

@end
