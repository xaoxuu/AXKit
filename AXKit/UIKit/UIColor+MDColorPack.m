//
//  UIColor+MDColorPack.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIColor+MDColorPack.h"
#import "UIColor+AXAdd.h"

@implementation UIColor (MDColorPack)


#pragma mark - material design color

#pragma mark red -> purple
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
#pragma mark blue -> cyan
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
#pragma mark green -> yellow
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
#pragma mark orange -> gray
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


@end

