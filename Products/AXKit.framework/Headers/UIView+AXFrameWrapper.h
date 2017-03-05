//
//  UIView+AXFrameWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - inline function

#pragma mark UIView



@interface UIView (AXFrameWrapper)

#pragma mark - property

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


#pragma mark - chain


// width
- (UIView *(^)(CGFloat))widthEqual;
// height
- (UIView *(^)(CGFloat))heightEqual;
// width and height
- (UIView *(^)(CGFloat))widthAndHeightEqual;
// center
- (UIView *(^)(UIView *))centerEqual;

// left and right
- (UIView *(^)(CGFloat))leftAndRightMargin;
// top and bottom
- (UIView *(^)(CGFloat))topAndBottomMargin;


@end
