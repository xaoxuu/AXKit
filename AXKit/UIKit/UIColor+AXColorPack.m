//
//  UIColor+AXColorPack.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIColor+AXColorPack.h"
#import "UIColor+AXAdd.h"

@implementation UIColor (AXColorPack)

// MARK: - [红色 -> 蓝色) ==================================================
+ (UIColor *)ax_lightRed {
    return [UIColor colorWithHex:@"#FF6868"];
}
+ (UIColor *)ax_red {
    return [UIColor colorWithHex:@"#F05153"];
}

+ (UIColor *)ax_lightPurple {
    return [UIColor colorWithHex:@"#B6A5F4"];
}

// MARK: - [蓝色 -> 绿色) ==================================================
+ (UIColor *)ax_blue {
    return [UIColor colorWithHex:@"#52A1F8"];
}


// MARK: - [绿色 -> 黄色) ==================================================
+ (UIColor *)ax_cyan {
    return [UIColor colorWithHex:@"#66CDFA"];
}

+ (UIColor *)ax_green {
    return [UIColor colorWithHex:@"#7CC353"];
}

// MARK: - 黑白灰 ==================================================

@end
