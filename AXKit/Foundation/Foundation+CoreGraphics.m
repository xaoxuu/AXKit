//
//  Foundation+CoreGraphics.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "Foundation+CoreGraphics.h"


inline CGSize CGSizeUp(CGFloat upOffset){
    return CGSizeMake(0, -upOffset);
}

inline CGSize CGSizeDown(CGFloat downOffset){
    return CGSizeMake(0, downOffset);
}


inline CGRect CGRectWithTopMargin(CGFloat top){
    return CGRectMake(0, top, kScreenW, kScreenH-top);
}
inline CGRect CGRectWithTopAndBottomMargin(CGFloat top, CGFloat bottom){
    return CGRectMake(0, top, kScreenW, kScreenH-top-bottom);
}


inline AXUIntegerRange AXUIntegerRangeMake(NSUInteger minValue, NSUInteger maxValue){
    return (AXUIntegerRange){minValue,maxValue};
}

inline NSUInteger AXRandomUIntegerFrom(AXUIntegerRange length){
    return length.minValue + (NSUInteger)arc4random_uniform((int)length.maxValue-(int)length.minValue + 1);
}


inline CGRect CGRectWithViewInScreen(UIView *targetView){
    UIView *main = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return [targetView.superview convertRect:targetView.frame toView:main];
}

inline AXFloatRange AXFloatRangeMake(CGFloat minValue, CGFloat maxValue){
    return (AXFloatRange){minValue,maxValue};
}

