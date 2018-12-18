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

static dispatch_block_t block_hide;
static NSTimeInterval static_duration;

@implementation AXProgressHUD



+ (void)ax_target:(UIView *)target showInfo:(NSString *)info duration:(NSTimeInterval)duration {
    static_duration = duration;
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
    static_duration = duration;
    if (isShowing) {
        [self _hideTips];
    }
        sPopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.6*kScreenW, 30)];
        [self _initMaskView];
        [self setupLabelWithContent:info];
        [self moveToView:target point:point];
        [self pushTo:target duration:duration];

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
    sLabel.textColor = axThemeManager.color.theme;
    
    sLabel.top = 16;
    //    sLabel.height = sPopView.height - 32;
    sLabel.left = 16;
    sLabel.width = sPopView.width - 32;
    [sLabel sizeToFit];
    if (sLabel.width < sPopView.width - 32) {
        sLabel.centerX = sPopView.boundsCenter.x;
    }
    
    
    // view
    sPopView.backgroundColor = [UIColor whiteColor];
    sPopView.layer.masksToBounds = YES;
    
    sPopView.layer.cornerRadius = 10;
    sPopView.layer.setShadow(LayerShadowDownFloat);
    
    
//    sPopView.height = sLabel.top + sLabel.height + 16;
    sPopView.height = sLabel.height + 32;
    sPopView.center = UIViewController.rootViewController.view.boundsCenter;
    sMaskView.centerY = sPopView.boundsCenter.y;
    
    
    if (axThemeManager.color.theme.isLightColor) {
        sLabel.textColor = [axThemeManager.color.theme darken:0.3];
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
    static_duration = duration;
    if (block_hide) {
        dispatch_block_cancel(block_hide);
    }
    [self _hideTips];
    
    [view addSubview:sPopView];

    isShowing = YES;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut animations:^{
        [self _showTips];
    } completion:^(BOOL finished) {
        block_hide = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
            [self _dismissAnimation];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), block_hide);
    }];
    
    
}

+ (void)_dismissAnimation{
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut animations:^{
        [self _hideTips];
    } completion:^(BOOL finished) {
        isShowing = NO;
        [sPopView removeFromSuperview];
    }];
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
    sMaskView.layer.rounded();
    sMaskView.center = sPopView.boundsCenter;
    sPopView.maskView = sMaskView;
}



@end
