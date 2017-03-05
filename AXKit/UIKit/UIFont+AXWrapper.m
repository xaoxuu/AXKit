//
//  UIFont+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIFont+AXWrapper.h"


inline UIFont *FontWithSize(CGFloat size){
    return [UIFont systemFontOfSize:size];
}

inline UIFont *BoldFontWithSize(CGFloat size){
    return [UIFont boldSystemFontOfSize:size];
}

inline CGFloat HeightWithTextFontWidth(NSString *text,UIFont *font,CGFloat width){
    NSDictionary *dict = @{NSFontAttributeName:font};
    return [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size.height;
}


@implementation UIFont (AXWrapper)

@end
