//
//  UIView+AXAnimation.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIView+AXAnimation.h"

@implementation UIView (AXAnimatedWrapper)

#pragma mark - build in
- (void)ax_animatedScaleIn:(CGFloat)scale duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(scale, scale);
    [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:0.3f initialSpringVelocity:0.2f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:completion];
}


#pragma mark - action
- (void)ax_animatedScale:(CGFloat)scale duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    [UIView animateWithDuration:0.1*duration delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.9*duration delay:0.0f usingSpringWithDamping:0.3f initialSpringVelocity:0.1f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:completion];
    }];
    
}


#pragma mark - build out
- (void)ax_animatedScaleOut:(CGFloat)scale duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    self.alpha = 1;
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.1*duration delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.9*duration delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.1f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformMakeScale(0.1, 0.1);
            self.alpha = 0;
        } completion:completion];
    }];
    
}

#pragma mark - all


@end
