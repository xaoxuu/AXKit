//
//  Foundation+AXEventTarget.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "Foundation+AXEventTarget.h"
#import "UIView+AXAnimatedWrapper.h"

@implementation AXEventTarget


+ (instancetype)targetWithHandler:(void (^)(id sender))handler {
    return [[self alloc] initWithHandler:handler];
}

- (instancetype)initWithHandler:(void (^)(id sender))handler {
    if (self = [super init]) {
        self.handler = handler;
    }
    return self;
}

- (void)handleEvent:(id)sender{
    if (self.handler) {
        self.handler(sender);
    }
    if (self.view) {
        [self.view ax_animatedScale:self.scale duration:self.duration completion:nil];
    }
}

- (void)setupAnimationWithView:(UIView *)view scale:(CGFloat)scale duration:(NSTimeInterval)duration {
    self.view = view;
    self.scale = scale;
    self.duration = duration;
}


@end
