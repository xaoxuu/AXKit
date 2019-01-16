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


// MARK: - MaterialDesign 配色

+ (UIColor *)md_red{
    return [UIColor colorWithHex:@"#F44336"];
}
+ (UIColor *)md_pink{
    return [UIColor colorWithHex:@"#E91E63"];
}
+ (UIColor *)md_purple{
    return [UIColor colorWithHex:@"#9C27B0"];
}
+ (UIColor *)md_deepPurple{
    return [UIColor colorWithHex:@"#673AB7"];
}

+ (UIColor *)md_indigo{
    return [UIColor colorWithHex:@"#3F51B5"];
}
+ (UIColor *)md_blue{
    return [UIColor colorWithHex:@"#2196F3"];
}
+ (UIColor *)md_lightBlue{
    return [UIColor colorWithHex:@"#03A9F4"];
}
+ (UIColor *)md_cyan{
    return [UIColor colorWithHex:@"#00BCD4"];
}
+ (UIColor *)md_teal{
    return [UIColor colorWithHex:@"#009688"];
}

+ (UIColor *)md_green{
    return [UIColor colorWithHex:@"#4CAF50"];
}
+ (UIColor *)md_lightGreen{
    return [UIColor colorWithHex:@"#8BC34A"];
}
+ (UIColor *)md_lime{
    return [UIColor colorWithHex:@"#CDDC39"];
}
+ (UIColor *)md_yellow{
    return [UIColor colorWithHex:@"#FFEB3B"];
}
+ (UIColor *)md_amber{
    return [UIColor colorWithHex:@"#FFC107"];
}

+ (UIColor *)md_orange{
    return [UIColor colorWithHex:@"#FF9800"];
}
+ (UIColor *)md_deepOrange{
    return [UIColor colorWithHex:@"#FF5722"];
}
+ (UIColor *)md_brown{
    return [UIColor colorWithHex:@"#FF5722"];
}
+ (UIColor *)md_blueGray{
    return [UIColor colorWithHex:@"#607D8B"];
}
+ (UIColor *)md_gray{
    return [UIColor colorWithHex:@"#9E9E9E"];
}


// MARK: - macOS 配色

+ (UIColor *)mac_maximize{
    return [UIColor colorWithHex:@"#3DC550"];
}
+ (UIColor *)mac_minimize{
    return [UIColor colorWithHex:@"#FFBD2B"];
}
+ (UIColor *)mac_close{
    return [UIColor colorWithHex:@"#FE5F58"];
}
+ (UIColor *)mac_finder{
    return [UIColor colorWithHex:@"#1BCDFC"];
}


// MARK: - xaoxuu 配色

+ (UIColor *)ax_lightRed {
    return [UIColor colorWithHex:@"#FF6868"];
}
+ (UIColor *)ax_red {
    return [UIColor colorWithHex:@"#F05153"];
}

+ (UIColor *)ax_lightPurple {
    return [UIColor colorWithHex:@"#B6A5F4"];
}

+ (UIColor *)ax_blue {
    return [UIColor colorWithHex:@"#52A1F8"];
}

+ (UIColor *)ax_cyan {
    return [UIColor colorWithHex:@"#66CDFA"];
}

+ (UIColor *)ax_green {
    return [UIColor colorWithHex:@"#7CC353"];
}


@end
