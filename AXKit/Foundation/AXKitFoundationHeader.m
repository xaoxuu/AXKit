//
//  AXKitFoundationHeader.m
//  AXKit
//
//  Created by xaoxuu on 02/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AXKitFoundationHeader.h"
#import "UIColorManager.h"
#import "UIFontManager.h"
#import "UIThemeManager.h"

inline void axkit_active(void){
//    NSString *key = [NSBundle mainBundle].bundleIdentifier;
//    AXLogFormat(@"bundle id: %@", key);
    [UIColorManager sharedInstance];
    [UIFontManager sharedInstance];
    
}

@implementation AXKitFoundationHeader

@end
