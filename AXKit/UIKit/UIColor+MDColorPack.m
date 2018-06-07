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
    return UIColor.initWithHEX(@"#F44336");
}
+ (UIColor *)md_pink{
    return UIColor.initWithHEX(@"#E91E63");
}
+ (UIColor *)md_purple{
    return UIColor.initWithHEX(@"#9C27B0");
}
+ (UIColor *)md_deepPurple{
    return UIColor.initWithHEX(@"#673AB7");
}
#pragma mark blue -> cyan
+ (UIColor *)md_indigo{
    return UIColor.initWithHEX(@"#3F51B5");
}
+ (UIColor *)md_blue{
    return UIColor.initWithHEX(@"#2196F3");
}
+ (UIColor *)md_lightBlue{
    return UIColor.initWithHEX(@"#03A9F4");
}
+ (UIColor *)md_cyan{
    return UIColor.initWithHEX(@"#00BCD4");
}
+ (UIColor *)md_teal{
    return UIColor.initWithHEX(@"#009688");
}
#pragma mark green -> yellow
+ (UIColor *)md_green{
    return UIColor.initWithHEX(@"#4CAF50");
}
+ (UIColor *)md_lightGreen{
    return UIColor.initWithHEX(@"#8BC34A");
}
+ (UIColor *)md_lime{
    return UIColor.initWithHEX(@"#CDDC39");
}
+ (UIColor *)md_yellow{
    return UIColor.initWithHEX(@"#FFEB3B");
}
+ (UIColor *)md_amber{
    return UIColor.initWithHEX(@"#FFC107");
}
#pragma mark orange -> gray
+ (UIColor *)md_orange{
    return UIColor.initWithHEX(@"#FF9800");
}
+ (UIColor *)md_deepOrange{
    return UIColor.initWithHEX(@"#FF5722");
}
+ (UIColor *)md_brown{
    return UIColor.initWithHEX(@"#FF5722");
}
+ (UIColor *)md_blueGray{
    return UIColor.initWithHEX(@"#607D8B");
}
+ (UIColor *)md_gray{
    return UIColor.initWithHEX(@"#9E9E9E");
}


@end

