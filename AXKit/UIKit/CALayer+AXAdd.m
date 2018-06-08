//
//  CALayer+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 01/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CALayer+AXAdd.h"


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

static inline void addColorAnimation(CALayer *layer, UIColor *color, void (^callback)(CABasicAnimation *animation)){
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


static inline void removeColorAnimation(CALayer *layer){
    [layer removeAnimationForKey:@"backgroundColor"];
}


@implementation CALayer (AXAdd)


+ (CALayer *(^)(CGSize))initWithSize{
    return ^CALayer *(CGSize size){
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, size.width, size.height);
        return layer;
    };
}

- (void (^)(CALayer *layer))addSublayer{
    return ^(CALayer *layer){
        [self addSublayer:layer];
    };
}

#pragma mark - corner


- (CALayer *(^)(CGFloat))setCornerRadius{
    return ^CALayer *(CGFloat cornerRadius){
        self.cornerRadius = cornerRadius;
        return self;
    };
}

- (CALayer *(^)(void))rounded{
    return ^CALayer *{
        self.cornerRadius = 0.5 * fmin(self.frame.size.width, self.frame.size.height);
        return self;
    };
}

#pragma mark - shadow

- (CALayer *(^)(LayerShadow shadow))setShadow{
    return ^CALayer *(LayerShadow shadow){
        setLayerShadow(self, shadow);
        return self;
    };
}

- (void)ax_cornerRadius:(CGFloat)cornerRadius shadow:(LayerShadow)shadow{
    self.cornerRadius = cornerRadius;
    setLayerShadow(self, shadow);
}
- (CALayer *(^)(CGFloat cornerRadius, LayerShadow shadow))roundedShadow{
    return ^CALayer *(CGFloat cornerRadius, LayerShadow shadow){
        self.cornerRadius = cornerRadius;
        setLayerShadow(self, shadow);
        return self;
    };
}

#pragma mark - border

- (CALayer *(^)(CGFloat))whiteBorder{
    return ^CALayer *(CGFloat borderWidth){
        self.borderColor = [UIColor whiteColor].CGColor;
        self.borderWidth = borderWidth;
        return self;
    };
}
- (CALayer *(^)(CGFloat, UIColor *))setBorder{
    return ^CALayer *(CGFloat borderWidth, UIColor *borderColor){
        self.borderColor = borderColor.CGColor;
        self.borderWidth = borderWidth;
        return self;
    };
}

#pragma mark - animation

- (void)ax_animatedColor:(UIColor *)color duration:(CFTimeInterval)duration repeatDuration:(CFTimeInterval)repeatDuration{
    addColorAnimation(self, color, ^(CABasicAnimation *animation) {
        animation.duration = duration;
        animation.repeatDuration = repeatDuration;
    });
}

- (void)ax_animatedColor:(UIColor *)color duration:(CFTimeInterval)duration repeatCount:(float)repeatCount{
    addColorAnimation(self, color, ^(CABasicAnimation *animation) {
        animation.duration = duration;
        animation.repeatCount = repeatCount;
    });
}

- (void)ax_removeColorAnimation{
    removeColorAnimation(self);
}


@end



