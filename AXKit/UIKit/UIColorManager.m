//
//  UIColorManager.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIColorManager.h"
#import "UIColor+MDColorPack.h"
#import "UIColor+AXExtension.h"
#import "NSUserDefaults+AXWrapper.h"

UIColorManager *axColor = nil;

#define CACHE_COLOR_THEME @"CACHE_COLOR_THEME"
#define CACHE_COLOR_ACCENT @"CACHE_COLOR_ACCENT"
#define CACHE_COLOR_BG @"CACHE_COLOR_BG"


@implementation UIThemeColorModel

- (instancetype)init{
    if (self = [super init]) {
        _groupTableViewBackground = [UIColor groupTableViewBackgroundColor].light;
        _separatorColor = _groupTableViewBackground.darkRatio(0.08);
        
    }
    return self;
}


#pragma mark - system color

- (UIColor *)black{
    return [UIColor blackColor];
}
- (UIColor *)darkGray{
    return [UIColor darkGrayColor];
}
- (UIColor *)gray{
    return [UIColor grayColor];
}
- (UIColor *)lightGray{
    return [UIColor lightGrayColor];
}
- (UIColor *)white{
    return [UIColor whiteColor];
}
- (UIColor *)clear{
    return [UIColor clearColor];
}


@end



@implementation UIColorManager

#pragma mark - color tool

- (void)configDefaultTheme:(void (^)(UIThemeColorModel * _Nonnull))defaultTheme{
    if (defaultTheme) {
        defaultTheme(self);
    }
    [NSUserDefaults ax_readStringForKey:CACHE_COLOR_THEME completion:^(NSString * _Nonnull string) {
        self.theme = [UIColor colorWithHexString:string];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [NSUserDefaults ax_readStringForKey:CACHE_COLOR_ACCENT completion:^(NSString * _Nonnull string) {
        self.accent = [UIColor colorWithHexString:string];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [NSUserDefaults ax_readStringForKey:CACHE_COLOR_BG completion:^(NSString * _Nonnull string) {
        self.background = [UIColor colorWithHexString:string];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}


- (void)saveCurrentTheme{
    [NSUserDefaults ax_setString:self.theme.hexString forKey:CACHE_COLOR_THEME];
    [NSUserDefaults ax_setString:self.accent.hexString forKey:CACHE_COLOR_ACCENT];
    [NSUserDefaults ax_setString:self.background.hexString forKey:CACHE_COLOR_BG];
}


#pragma mark - life circle

#pragma mark init

+ (void)load{
    [super load];
    [self defaultManager];
}

#pragma mark creator

// defaultManager
+ (instancetype)defaultManager{
    return [self sharedInstance];
}

// sharedInstance
+ (instancetype)sharedInstance{
    if (!axColor) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!axColor) {
                axColor = [[self alloc] init];
            }
        });
    }
    return axColor;
}

// allocWithZone
+ (instancetype) allocWithZone:(NSZone *)zone{
    if (!axColor) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!axColor) {
                axColor = [super allocWithZone:zone];
            }
        });
    }
    return axColor;
}

// init
- (instancetype)init{
    if (self = [super init]) {
        
    }
    
    // init
    
    
    return axColor;
    
}

// copyWithZone
+ (id)copyWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

// copyWithZone
- (id)copyWithZone:(struct _NSZone *)zone{
    return [UIColorManager sharedInstance];
}

// mutableCopyWithZone
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

// mutableCopyWithZone
- (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return [UIColorManager sharedInstance];
}

// copy
+ (id)copy{
    return [UIColorManager sharedInstance];
}

@end

