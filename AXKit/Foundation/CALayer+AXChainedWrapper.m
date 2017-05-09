//
//  CALayer+AXChainedWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CALayer+AXChainedWrapper.h"
#import "UIColorManager.h"

@implementation CALayer (AXChainedWrapper)

- (CALayer *(^)())ax_maskToCircle{
    return ^{
        self.masksToBounds = YES;
        self.cornerRadius = 0.5 * fmin(self.frame.size.width, self.frame.size.height);
        return self;
    };
}

#pragma mark - shadow

- (CALayer *(^)(AXShadow type))ax_shadow{
    return ^(AXShadow type){
        self.masksToBounds = NO;
        switch (type) {
                // for top bar
            case AXShadowDownLight: {
                self.shadowOpacity = 0.4;
                self.shadowRadius = 0.8;
                self.shadowOffset = CGSizeMake(0, 0.8);
                break;
            }
            case AXShadowDownNormal: {
                self.shadowOpacity = 0.4;
                self.shadowRadius = 1;
                self.shadowOffset = CGSizeMake(0, 1);
                break;
            }
                // for raised view
            case AXShadowDownFloat: {
                self.shadowOpacity = 0.4;
                self.shadowRadius = 3;
                self.shadowOffset = CGSizeMake(0, 2.8);
                break;
            }
                // for bottom bar
            case AXShadowUpLight: {
                self.shadowOpacity = 0.12;
                self.shadowRadius = 0.9;
                self.shadowOffset = CGSizeMake(0, -0.9);
                break;
            }
            case AXShadowUpNormal: {
                self.shadowOpacity = 0.4;
                self.shadowRadius = 0.8;
                self.shadowOffset = CGSizeMake(0, -0.8);
                break;
            }
                // for center views
            case AXShadowCenterLight: {
                self.shadowOpacity = 0.3;
                self.shadowRadius = 1;
                self.shadowOffset = CGSizeZero;
                break;
            }
            case AXShadowCenterNormal: {
                self.shadowOpacity = 0.7;
                self.shadowRadius = 1.2;
                self.shadowOffset = CGSizeZero;
                break;
            }
            case AXShadowCenterHeavy: {
                self.shadowOpacity = 0.8;
                self.shadowRadius = 1.5;
                self.shadowOffset = CGSizeZero;
                break;
            }
        }
        return self;
    };
    
}

#pragma mark - border

- (CALayer *(^)(CGFloat width))ax_whiteBorder{
    return ^(CGFloat width){
        self.borderColor = [UIColor whiteColor].CGColor;
        self.borderWidth = width;
        return self;
    };
}

- (CALayer *(^)(CGFloat width))ax_themeBorder{
    return ^(CGFloat width){
        self.borderColor = axColor.theme.CGColor;
        self.borderWidth = width;
        return self;
    };
}


@end



