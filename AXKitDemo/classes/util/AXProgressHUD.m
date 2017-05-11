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


- (void)ax_showInfo:(NSString *)info duration:(NSTimeInterval)duration{
    popView = [[UIView alloc] initWithFrame:CGRectMake(16, 28, 0.6*kScreenW, kNavBarHeight)];
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    
    popView.backgroundColor = axColor.white;
    maskView.backgroundColor = [UIColor whiteColor];
//    maskView.layer.ax_maskToCircle();
    maskView.layer.cornerRadius = 1;
    popView.maskView = maskView;
    
    
    
    // label
    sLabel = [[UILabel alloc] init];
    [popView addSubview:sLabel];
    sLabel.numberOfLines = 0;
    sLabel.text = info;
//    sLabel.font = [UIFont systemFontOfSize:13];
    sLabel.textColor = axColor.theme;
    sLabel.width = popView.width - 32;
    sLabel.centerX = popView.centerX;
    [sLabel sizeToFit];
    sLabel.centerY = popView.centerY;
    
    // view
    popView.backgroundColor = [UIColor whiteColor];
    popView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    popView.layer.cornerRadius = 12;
    popView.layer.ax_shadow(AXShadowDownFloat);
    
    popView.height = sLabel.top + sLabel.height + 16;
    popView.height = popView.width;
    popView.centerX = kScreenCenterX;
    popView.centerY = kScreenCenterY;
    maskView.centerX = 0.5 * popView.width;
    maskView.centerY = 0.4 * popView.height;
    
//    [self _hideTips];
    
    [self.rootVC.view addSubview:popView];
    
    
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.rootVC.view.layer.cornerRadius = 12;
            popView.alpha = 1;
            popView.backgroundColor = [UIColor whiteColor];
            popView.transform = CGAffineTransformIdentity;
            maskView.transform = CGAffineTransformMakeScale(50, 50);
        } completion:^(BOOL finished) {
            
            [NSBlockOperation ax_delay:duration performInMainQueue:^{
                [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.rootVC.view.layer.cornerRadius = 0;
                    popView.alpha = 0;
                    popView.backgroundColor = [UIColor lightGrayColor];
                    popView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                    maskView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    
                    [popView removeFromSuperview];
                }];
            }];
        }];
    
    
}


+ (void)ax_target:(UIView *)target showInfo:(NSString *)info duration:(NSTimeInterval)duration {
    if (!isShowing) {
        sPopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.6*kScreenW, 30)];
        [self _initMaskView];
        [self setupLabelWithContent:info];
        [self pushTo:target duration:duration];
    }
}

+ (void)ax_target:(UIView *)target point:(CGPoint)point showInfo:(NSString *)info duration:(NSTimeInterval)duration {
    if (!isShowing) {
        sPopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.6*kScreenW, 30)];
        [self _initMaskView];
        [self setupLabelWithContent:info];
        [self moveToView:target point:point];
        [self pushTo:target duration:duration];
    }
}

// setup label
+ (void)setupLabelWithContent:(NSString *)content{
    // label
    sLabel = [[UILabel alloc] init];
    [sPopView addSubview:sLabel];
    sLabel.numberOfLines = 0;
    sLabel.text = content;
    sLabel.font = [UIFont systemFontOfSize:13];
    sLabel.textColor = axColor.theme;
    sLabel.width = sPopView.width - 32;
    sLabel.centerX = sPopView.centerX;
    sLabel.top = 16;
    [sLabel sizeToFit];
    
    // view
    sPopView.backgroundColor = [UIColor whiteColor];
    sPopView.layer.masksToBounds = YES;
    
    sPopView.layer.cornerRadius = 10;
    sPopView.layer.ax_shadow(AXShadowDownFloat);
    
//    sPopView.height = sLabel.top + sLabel.height + 16;
    sPopView.height = sPopView.width;
    sPopView.centerX = kScreenCenterX;
    sPopView.centerY = kScreenCenterY;
    
}

+ (void)moveToView:(UIView *)view point:(CGPoint)point{
    sPopView.center = point;
    if (sPopView.right > view.width) {
        sPopView.right = view.width - 8;
    }
    if (sPopView.bottom > view.height) {
        sPopView.bottom = view.height - 8;
    }
    if (sPopView.left < 0) {
        sPopView.left = 8;
    }
    if (sPopView.top < 0) {
        sPopView.top = 8;
    }
}


+ (void)pushTo:(UIView *)view duration:(NSTimeInterval)duration{
    [self _hideTips];
    
    [view addSubview:sPopView];
    if (!isShowing) {
        isShowing = YES;
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self _showTips];
        } completion:^(BOOL finished) {
            [self performSelector:@selector(_dismissAnimation) withObject:nil afterDelay:duration];
        }];
    }
}

+ (void)_dismissAnimation{
    if (isShowing) {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self _hideTips];
        } completion:^(BOOL finished) {
            isShowing = NO;
            [sPopView removeFromSuperview];
        }];
    }
}

+ (void)_hideTips{
    sPopView.alpha = 0;
    sPopView.backgroundColor = [UIColor lightGrayColor];
    sPopView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    sMaskView.transform = CGAffineTransformIdentity;
}

+ (void)_showTips{
    sPopView.alpha = 1;
    sPopView.backgroundColor = [UIColor whiteColor];
    sPopView.transform = CGAffineTransformIdentity;
    sMaskView.transform = CGAffineTransformMakeScale(40, 40);
}

+ (void)_initMaskView{
    sMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    sMaskView.backgroundColor = [UIColor whiteColor];
    sMaskView.layer.ax_maskToCircle();
    sMaskView.centerX = 0.5 * sPopView.width;
    sMaskView.centerY = 0.5 * sPopView.height;
    sPopView.maskView = sMaskView;
}



@end
