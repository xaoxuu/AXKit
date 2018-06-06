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


+ (UIColor *)ax_red {
    static UIColor *color;
    if (!color) {
        color = [UIColor colorWithHexString:@"#F05153"];
    }
    return color;
}

+ (UIColor *)ax_lightRed {
    static UIColor *color;
    if (!color) {
        color = [UIColor colorWithHexString:@"#FF6868"];
    }
    return color;
}

+ (UIColor *)ax_green {
    static UIColor *color;
    if (!color) {
        color = [UIColor colorWithHexString:@"#7CC353"];
    }
    return color;
}

+ (UIColor *)ax_cyan {
    static UIColor *color;
    if (!color) {
        color = [UIColor colorWithHexString:@"#66CDFA"];
    }
    return color;
}

+ (UIColor *)ax_blue {
    static UIColor *color;
    if (!color) {
        color = [UIColor colorWithHexString:@"#52A1F8"];
    }
    return color;
}



@end
