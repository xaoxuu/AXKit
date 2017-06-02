//
//  UIView+AXFrameExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (AXFrameWrapper)


#pragma mark - property
// frame.origin
@property (nonatomic, readwrite, assign) CGPoint origin;
// frame.size
@property (nonatomic, readwrite, assign) CGSize  size;
// frame.size.width
@property (nonatomic, readwrite, assign) CGFloat width;
// frame.size.height
@property (nonatomic, readwrite, assign) CGFloat height;
// frame.origin.x
@property (nonatomic, readwrite, assign) CGFloat left;
// frame.origin.x + frame.size.width
@property (nonatomic, readwrite, assign) CGFloat right;
// frame.origin.y
@property (nonatomic, readwrite, assign) CGFloat top;
// frame.origin.y + frame.size.height
@property (nonatomic, readwrite, assign) CGFloat bottom;

#pragma mark frame center
// frame.origin.x + 0.5 * frame.size.width
@property (nonatomic, readwrite, assign) CGFloat centerX;
// frame.origin.y + 0.5 * frame.size.height
@property (nonatomic, readwrite, assign) CGFloat centerY;


#pragma mark bounds center
// bounds.center
@property (nonatomic, readonly, assign) CGPoint boundsCenter;
// 0.5 * frame.size.width
@property (nonatomic, readonly, assign) CGFloat boundsCenterX;
// 0.5 * frame.size.height
@property (nonatomic, readonly, assign) CGFloat boundsCenterY;



@end
