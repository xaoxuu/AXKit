//
//  UIFontManager.m
//  AXKit
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIFontManager.h"

UIFontManager *axFont = nil;

@implementation UIFontManager


- (void)setPrefersFontSize:(CGFloat)prefersFontSize{
    _prefersFontSize = prefersFontSize;
    CGFloat standard = [UIFont systemFontSize]; //14
    CGFloat small = [UIFont smallSystemFontSize]; //12
    
    CGFloat ratio = prefersFontSize / standard;
    
    _customSmall = [UIFont systemFontOfSize:small * ratio];
    _customBoldSmall = [UIFont boldSystemFontOfSize:small * ratio];
    _customNormal = [UIFont systemFontOfSize:standard * ratio];
    _customBoldNormal = [UIFont boldSystemFontOfSize:standard * ratio];
    _customLarge = [UIFont systemFontOfSize:standard * 1.2 * ratio];
    _customBoldLarge = [UIFont boldSystemFontOfSize:standard * 1.2 * ratio];
    
    
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
