//
//  UIView+AXFrameWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>





#pragma mark UIView



@interface UIView (AXFrameWrapper)


/**
 对frame进行若干操作

 @param frame frame
 */
- (void)ax_frame:(CGRect (^)(CGRect frame))frame;

#pragma mark - property

@property (nonatomic, readwrite, assign) CGPoint origin;
@property (nonatomic, readwrite, assign) CGSize  size;

@property (nonatomic, readwrite, assign) CGFloat width;
@property (nonatomic, readwrite, assign) CGFloat height;

@property (nonatomic, readwrite, assign) CGFloat left;
@property (nonatomic, readwrite, assign) CGFloat right;
@property (nonatomic, readwrite, assign) CGFloat top;
@property (nonatomic, readwrite, assign) CGFloat bottom;

#pragma mark frame center

@property (nonatomic, readwrite, assign) CGPoint frameCenter;
@property (nonatomic, readwrite, assign) CGFloat frameCenterX;
@property (nonatomic, readwrite, assign) CGFloat frameCenterY;


#pragma mark bounds center
@property (nonatomic, readonly, assign) CGPoint boundsCenter;
@property (nonatomic, readonly, assign) CGFloat boundsCenterX;
@property (nonatomic, readonly, assign) CGFloat boundsCenterY;



@end
