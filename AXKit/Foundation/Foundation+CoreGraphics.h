//
//  Foundation+CoreGraphics.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import <UIKit/UIKit.h>


// screen marco
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenCenterX (0.5 * kScreenW)
#define kScreenCenterY (0.5 * kScreenH)



#pragma mark CGSize

/**
 CGSizeUp

 @param upOffset	up offset

 @return a size
 */
CG_EXTERN CGSize CGSizeUp(CGFloat upOffset);

/**
 CGSizeDown

 @param downOffset down offset

 @return a size
 */
CG_EXTERN CGSize CGSizeDown(CGFloat downOffset);

#pragma mark CGRect

/**
 CGRectWithTopMargin

 @param top top margin

 @return a rect
 */
CG_EXTERN CGRect CGRectWithTopMargin(CGFloat top);

/**
 CGRectWithTopAndBottomMargin

 @param top    top margin
 @param bottom bottom margin

 @return a rect
 */
CG_EXTERN CGRect CGRectWithTopAndBottomMargin(CGFloat top, CGFloat bottom);

/**
 convert the target view's frame to superview

 @param targetView target view

 @return a rect
 */
CG_EXTERN CGRect CGRectWithViewInScreen(UIView *targetView);


struct AXUIntegerRange {
    NSUInteger minValue;
    NSUInteger maxValue;
};

typedef struct AXUIntegerRange AXUIntegerRange;

/**
 get a length range

 @param minValue min length
 @param maxValue max length

 @return a length range
 */
CG_EXTERN AXUIntegerRange AXUIntegerRangeMake(NSUInteger minValue, NSUInteger maxValue);

/**
 get a random from length range

 @param range langth range

 @return a random length
 */
CG_EXTERN NSUInteger AXRandomUIntegerFrom(AXUIntegerRange range);


struct AXFloatRange{
    CGFloat minValue;
    CGFloat maxValue;
};
typedef struct AXFloatRange AXFloatRange;

/**
 get a CGFloat range

 @param minValue min value
 @param maxValue max value

 @return a CGFloat range
 */
CG_EXTERN AXFloatRange AXFloatRangeMake(CGFloat minValue, CGFloat maxValue);




