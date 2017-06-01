//
//  CALayer+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 01/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CALayer+AXWrapper.h"

@implementation CALayer (AXWrapper)


#pragma mark - corner

- (void)ax_maskToCircle{
    self.masksToBounds = YES;
    self.cornerRadius = 0.5 * fmin(self.frame.size.width, self.frame.size.height);
}


#pragma mark - shadow

- (void)ax_shadow:(LayerShadow)shadow{
    self.masksToBounds = NO;
    switch (shadow) {
            // for top bar
        case LayerShadowDownLight: {
            self.shadowOpacity = 0.3;
            self.shadowRadius = 1;
            self.shadowOffset = CGSizeMake(0, 1);
            break;
        }
        case LayerShadowDownNormal: {
            self.shadowOpacity = 0.3;
            self.shadowRadius = 1.2;
            self.shadowOffset = CGSizeMake(0, 1.2);
            break;
        }
            // for raised view
        case LayerShadowDownFloat: {
            self.shadowOpacity = 0.2;
            self.shadowRadius = 5;
            self.shadowOffset = CGSizeMake(0, 4);
            break;
        }
            // for bottom bar
        case LayerShadowUpLight: {
            self.shadowOpacity = 0.1;
            self.shadowRadius = 1;
            self.shadowOffset = CGSizeMake(0, -1);
            break;
        }
        case LayerShadowUpNormal: {
            self.shadowOpacity = 0.3;
            self.shadowRadius = 1;
            self.shadowOffset = CGSizeMake(0, -1);
            break;
        }
            // for center views
        case LayerShadowCenterLight: {
            self.shadowOpacity = 0.3;
            self.shadowRadius = 1.2;
            self.shadowOffset = CGSizeZero;
            break;
        }
        case LayerShadowCenterNormal: {
            self.shadowOpacity = 0.7;
            self.shadowRadius = 1.2;
            self.shadowOffset = CGSizeZero;
            break;
        }
        case LayerShadowCenterHeavy: {
            self.shadowOpacity = 0.8;
            self.shadowRadius = 1.5;
            self.shadowOffset = CGSizeZero;
            break;
        }
    }
}

- (void)ax_cornerRadius:(CGFloat)cornerRadius shadow:(LayerShadow)shadow{
    self.cornerRadius = cornerRadius;
    switch (shadow) {
            // for top bar
        case LayerShadowDownLight: {
            self.shadowOpacity = 0.3;
            self.shadowRadius = 1;
            self.shadowOffset = CGSizeMake(0, 1);
            break;
        }
        case LayerShadowDownNormal: {
            self.shadowOpacity = 0.3;
            self.shadowRadius = 1.2;
            self.shadowOffset = CGSizeMake(0, 1.2);
            break;
        }
            // for raised view
        case LayerShadowDownFloat: {
            self.shadowOpacity = 0.2;
            self.shadowRadius = 5;
            self.shadowOffset = CGSizeMake(0, 4);
            break;
        }
            // for bottom bar
        case LayerShadowUpLight: {
            self.shadowOpacity = 0.1;
            self.shadowRadius = 1;
            self.shadowOffset = CGSizeMake(0, -1);
            break;
        }
        case LayerShadowUpNormal: {
            self.shadowOpacity = 0.3;
            self.shadowRadius = 1;
            self.shadowOffset = CGSizeMake(0, -1);
            break;
        }
            // for center views
        case LayerShadowCenterLight: {
            self.shadowOpacity = 0.3;
            self.shadowRadius = 1.2;
            self.shadowOffset = CGSizeZero;
            break;
        }
        case LayerShadowCenterNormal: {
            self.shadowOpacity = 0.7;
            self.shadowRadius = 1.2;
            self.shadowOffset = CGSizeZero;
            break;
        }
        case LayerShadowCenterHeavy: {
            self.shadowOpacity = 0.8;
            self.shadowRadius = 1.5;
            self.shadowOffset = CGSizeZero;
            break;
        }
    }
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


@end



