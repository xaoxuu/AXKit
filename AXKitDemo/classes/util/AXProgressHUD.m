//
//  AXProgressHUD.m
//  AXKit
//
//  Created by xaoxuu on 10/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AXProgressHUD.h"


static UIView *sPopView;

static UIView *sMaskView;

// label
static UILabel *sLabel;

static BOOL isShowing = NO;


static UIView *popView;
static UIView *maskView;



@implementation AXProgressHUD



+ (void)ax_target:(UIView *)target showInfo:(NSString *)info duration:(NSTimeInterval)duration {
//    if (!isShowing) {
    if (isShowing) {
        [self _hideTips];
    }
        sPopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.6*kScreenW, 30)];
        [self _initMaskView];
        [self setupLabelWithContent:info];
        [self pushTo:target duration:duration];
//    } else {
//        [self _hideTips];
//        
//    }
}

+ (void)ax_target:(UIView *)target point:(CGPoint)point showInfo:(NSString *)info duration:(NSTimeInterval)duration {
//    if (!isShowing) {
    if (isShowing) {
        [self _hideTips];
    }
        sPopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.6*kScreenW, 30)];
        [self _initMaskView];
        [self setupLabelWithContent:info];
        [self moveToView:target point:point];
        [self pushTo:target duration:duration];
//    } else {
//        [self _hideTips];
//        
//    }
}

// setup label
+ (void)setupLabelWithContent:(NSString *)content{
    // label
    sLabel = [[UILabel alloc] init];
    [sPopView addSubview:sLabel];
    sLabel.numberOfLines = 0;
    sLabel.text = content;
    sLabel.font = [UIFont boldSystemFontOfSize:14];
    sLabel.textAlignment = NSTextAlignmentCenter;
    sLabel.textColor = axColor.theme;
    
    sLabel.top = 16;
    //    sLabel.height = sPopView.height - 32;
    sLabel.left = 16;
    sLabel.width = sPopView.width - 32;
    [sLabel sizeToFit];
    if (sLabel.width < sPopView.width - 32) {
        sLabel.centerX = sPopView.boundsCenterX;
    }
    
    
    // view
    sPopView.backgroundColor = [UIColor whiteColor];
    sPopView.layer.masksToBounds = YES;
    
    sPopView.layer.cornerRadius = 10;
    [sPopView.layer ax_shadow:LayerShadowDownFloat];
    
    
    
//    sPopView.height = sLabel.top + sLabel.height + 16;
    sPopView.height = sLabel.height + 32;
    sPopView.center = AXRootViewController().view.boundsCenter;
    sMaskView.centerY = sPopView.boundsCenterY;
    
    
    if (axColor.theme.isLightColor) {
        sLabel.textColor = axColor.theme.darkRatio(0.3);
    }
    
    
}

+ (void)moveToView:(UIView *)view point:(CGPoint)point{
    sPopView.center = point;
    if (sPopView.right > view.width) {
        sPopView.right = view.width - 8;
    }
    if (sPopView.bottom > view.height) {
        sPopView.bottom = view.height - 8;
    }
    if (sPopView.left < 8) {
        sPopView.left = 8;
    }
    if (sPopView.top < 28) {
        sPopView.top = 28;
    }
}


+ (void)pushTo:(UIView *)view duration:(NSTimeInterval)duration{
    [self _hideTips];
    
    [view addSubview:sPopView];
//    if (!isShowing) {
        isShowing = YES;
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self _showTips];
        } completion:^(BOOL finished) {
            [self performSelector:@selector(_dismissAnimation) withObject:nil afterDelay:duration];
        }];
//    } else {
//        
//    }
}

+ (void)_dismissAnimation{
    if (isShowing) {
        [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self _hideTips];
        } completion:^(BOOL finished) {
            isShowing = NO;
            [sPopView removeFromSuperview];
        }];
    }
}

+ (void)_hideTips{
    popView = sPopView;
    maskView = sMaskView;
    popView.alpha = 0;
    popView.backgroundColor = [UIColor lightGrayColor];
    popView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    sMaskView.transform = CGAffineTransformIdentity;
}

+ (void)_showTips{
    sPopView.alpha = 1;
    sPopView.backgroundColor = [UIColor whiteColor];
    sPopView.transform = CGAffineTransformIdentity;
    sMaskView.transform = CGAffineTransformMakeScale(80, 80);
}

+ (void)_initMaskView{
    sMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    sMaskView.backgroundColor = [UIColor whiteColor];
    [sMaskView.layer ax_maskToCircle];
    sMaskView.center = sPopView.boundsCenter;
    sPopView.maskView = sMaskView;
}



@end
