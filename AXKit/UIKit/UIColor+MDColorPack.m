//
//  UIColor+MDColorPack.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIColor+MDColorPack.h"
#import "UIColor+AXExtension.h"

@implementation UIColor (MDColorPack)


#pragma mark - material design color

#pragma mark red -> purple
+ (UIColor *)md_red{
    return [UIColor colorWithHexString:@"#F44336"];
}
+ (UIColor *)md_pink{
    return [UIColor colorWithHexString:@"#E91E63"];
}
+ (UIColor *)md_purple{
    return [UIColor colorWithHexString:@"#9C27B0"];
}
+ (UIColor *)md_deepPurple{
    return [UIColor colorWithHexString:@"#673AB7"];
}
#pragma mark blue -> cyan
+ (UIColor *)md_indigo{
    return [UIColor colorWithHexString:@"#3F51B5"];
}
+ (UIColor *)md_blue{
    return [UIColor colorWithHexString:@"#2196F3"];
}
+ (UIColor *)md_lightBlue{
    return [UIColor colorWithHexString:@"#03A9F4"];
}
+ (UIColor *)md_cyan{
    return [UIColor colorWithHexString:@"#00BCD4"];
}
+ (UIColor *)md_teal{
    return [UIColor colorWithHexString:@"#009688"];
}
#pragma mark green -> yellow
+ (UIColor *)md_green{
    return [UIColor colorWithHexString:@"#4CAF50"];
}
+ (UIColor *)md_lightGreen{
    return [UIColor colorWithHexString:@"#8BC34A"];
}
+ (UIColor *)md_lime{
    return [UIColor colorWithHexString:@"#CDDC39"];
}
+ (UIColor *)md_yellow{
    return [UIColor colorWithHexString:@"#FFEB3B"];
}
+ (UIColor *)md_amber{
    return [UIColor colorWithHexString:@"#FFC107"];
}
#pragma mark orange -> gray
+ (UIColor *)md_orange{
    return [UIColor colorWithHexString:@"#FF9800"];
}
+ (UIColor *)md_deepOrange{
    return [UIColor colorWithHexString:@"#FF5722"];
}
+ (UIColor *)md_brown{
    return [UIColor colorWithHexString:@"#FF5722"];
}
+ (UIColor *)md_blueGray{
    return [UIColor colorWithHexString:@"#607D8B"];
}
+ (UIColor *)md_gray{
    return [UIColor colorWithHexString:@"#9E9E9E"];
}


@end

