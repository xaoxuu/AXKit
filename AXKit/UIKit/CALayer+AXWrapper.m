//
//  CALayer+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 01/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CALayer+AXWrapper.h"

static inline void setLayerShadow(CALayer *layer, LayerShadow shadow){
    switch (shadow) {
        case LayerShadowNone: {
            layer.shadowOpacity = 0;
            layer.shadowRadius = 0;
            layer.shadowOffset = CGSizeZero;
            break;
        }
            // for top bar
        case LayerShadowDownLight: {
            layer.shadowOpacity = 0.2;
            layer.shadowRadius = 1;
            layer.shadowOffset = CGSizeMake(0, 1);
            break;
        }
        case LayerShadowDownNormal: {
            layer.shadowOpacity = 0.3;
            layer.shadowRadius = 1.2;
            layer.shadowOffset = CGSizeMake(0, 1.2);
            break;
        }
            // for raised view
        case LayerShadowDownFloat: {
            layer.shadowOpacity = 0.3;
            layer.shadowRadius = 5;
            layer.shadowOffset = CGSizeMake(0, 5);
            break;
        }
            // for bottom bar
        case LayerShadowUpLight: {
            layer.shadowOpacity = 0.08;
            layer.shadowRadius = 1;
            layer.shadowOffset = CGSizeMake(0, -1);
            break;
        }
        case LayerShadowUpNormal: {
            layer.shadowOpacity = 0.3;
            layer.shadowRadius = 1;
            layer.shadowOffset = CGSizeMake(0, -1);
            break;
        }
            // for center views
        case LayerShadowCenterLight: {
            layer.shadowOpacity = 0.3;
            layer.shadowRadius = 1.2;
            layer.shadowOffset = CGSizeZero;
            break;
        }
        case LayerShadowCenterNormal: {
            layer.shadowOpacity = 0.7;
            layer.shadowRadius = 1.2;
            layer.shadowOffset = CGSizeZero;
            break;
        }
        case LayerShadowCenterHeavy: {
            layer.shadowOpacity = 0.8;
            layer.shadowRadius = 1.5;
            layer.shadowOffset = CGSizeZero;
            break;
        }
    }
}



static inline void showColorAnimation(CALayer *layer, UIColor *color, void (^callback)(CABasicAnimation *animation)){
    static CABasicAnimation *animation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        animation.autoreverses = YES;
        animation.removedOnCompletion = YES;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animation.duration = 1;
        animation.repeatCount = 1;
    });
    animation.toValue = (id)color.CGColor;
    if (callback) {
        callback(animation);
    }
    [layer addAnimation:animation forKey:@"backgroundColor"];
}


static inline void hideColorAnimation(CALayer *layer){
    [layer removeAnimationForKey:@"backgroundColor"];
}


@implementation CALayer (AXWrapper)


#pragma mark - corner

- (void)ax_maskToCircle{
    self.masksToBounds = YES;
    self.cornerRadius = 0.5 * fmin(self.frame.size.width, self.frame.size.height);
}


#pragma mark - shadow

- (void)ax_shadow:(LayerShadow)shadow{
    self.masksToBounds = NO;
    setLayerShadow(self, shadow);
}

- (void)ax_cornerRadius:(CGFloat)cornerRadius shadow:(LayerShadow)shadow{
    self.cornerRadius = cornerRadius;
    setLayerShadow(self, shadow);
}

- (void)ax_customShadowWithOpacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset{
    self.masksToBounds = NO;
    self.shadowOpacity = opacity;
    self.shadowRadius = radius;
    self.shadowOffset = offset;
}

- (void)ax_customShadowWithOpacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset color:(UIColor *)color path:(CGPathRef)path{
    [self ax_customShadowWithOpacity:opacity radius:radius offset:offset];
    self.shadowColor = color.CGColor;
    self.shadowPath = path;
}


#pragma mark - border

- (void)ax_whiteBorder:(CGFloat)width{
    self.borderColor = [UIColor whiteColor].CGColor;
    self.borderWidth = width;
}

- (void)ax_borderWidth:(CGFloat)width color:(UIColor *)color{
    self.borderColor = color.CGColor;
    self.borderWidth = width;
}

#pragma mark - animation

- (void)ax_showAnimatedColor:(UIColor *)color duration:(CFTimeInterval)duration repeatDuration:(CFTimeInterval)repeatDuration{
    showColorAnimation(self, color, ^(CABasicAnimation *animation) {
        animation.duration = duration;
        animation.repeatDuration = repeatDuration;
    });
}

- (void)ax_showAnimatedColor:(UIColor *)color duration:(CFTimeInterval)duration repeatCount:(float)repeatCount{
    showColorAnimation(self, color, ^(CABasicAnimation *animation) {
        animation.duration = duration;
        animation.repeatCount = repeatCount;
    });
}

- (void)ax_hideColorAnimation{
    hideColorAnimation(self);
}


@end



