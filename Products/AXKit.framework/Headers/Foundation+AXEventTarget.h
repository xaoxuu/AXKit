//
//  Foundation+AXEventTarget.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AXEventTarget : NSObject

// target handler
@property (copy, nonatomic) void (^handler)(id sender);

// animation view
@property (strong, nonatomic) UIView *view;
// scale
@property (assign, nonatomic) CGFloat scale;
// duration
@property (assign, nonatomic) NSTimeInterval duration;


+ (instancetype)targetWithHandler:(void (^)(id sender))handler;

- (void)setupAnimationWithView:(UIView *)view scale:(CGFloat)scale duration:(NSTimeInterval)duration;

- (void)handleEvent:(id)sender;

@end


