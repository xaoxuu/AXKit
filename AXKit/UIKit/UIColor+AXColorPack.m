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
        color = UIColor.initWithHEX(@"#F05153");
    }
    return color;
}

+ (UIColor *)ax_lightRed {
    static UIColor *color;
    if (!color) {
        color = UIColor.initWithHEX(@"#FF6868");
    }
    return color;
}

+ (UIColor *)ax_green {
    static UIColor *color;
    if (!color) {
        color = UIColor.initWithHEX(@"#7CC353");
    }
    return color;
}

+ (UIColor *)ax_cyan {
    static UIColor *color;
    if (!color) {
        color = UIColor.initWithHEX(@"#66CDFA");
    }
    return color;
}

+ (UIColor *)ax_blue {
    static UIColor *color;
    if (!color) {
        color = UIColor.initWithHEX(@"#52A1F8");
    }
    return color;
}



@end
