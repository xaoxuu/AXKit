//
//  AXStatusBar.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AXStatusBar.h"
#import "NSOperation+AXExtension.h"
#import "CALayer+AXWrapper.h"
#import "UIColor+AXExtension.h"
#import "CALayer+AXWrapper.h"
#import "UIColor+MDColorPack.h"
#import "CoreGraphics+AXExtension.h"

// 是否正在展示状态栏消息
static BOOL isStatusMessageShowing;
static BOOL isStatusProgressMessageShowing;

static CALayer *progressLayer;


/**
 获取状态栏（如果要自定义状态栏，建议使用+[ax_getCustomStatusBar]）
 
 @return 系统状态栏
 */
static inline UIView *getSystemStatusBar(){
    return [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
}

/**
 获取可自定义的状态栏
 
 @return 自定义状态栏
 */
static inline UIView *getCustomStatusBar(){
    static UIView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[UIView alloc] initWithFrame:getSystemStatusBar().bounds];
        [getSystemStatusBar() insertSubview:view atIndex:0];
    });
    return view;
}

/**
 获取状态栏消息视图
 
 @return 状态栏消息视图
 */
static inline UIView *getStatusBarMessageContentView(){
    static UIView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect frame = getSystemStatusBar().bounds;
        if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)) {
            frame.size.height += 6;
        }
        view = [[UIView alloc] initWithFrame:frame];
        [getSystemStatusBar() addSubview:view];
        
    });
    return view;
}
static inline UIView *getStatusBarProgressMessageContentView(){
    static UIView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        const CGFloat height = 20;
        view = [[UIView alloc] init];
        CGSize statusBarSize = getSystemStatusBar().bounds.size;
        if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)) {
            const CGFloat width = 64;
            CGRect frame = CGRectMake((statusBarSize.width - width)/2, 0, width, 20);
            frame.origin = CGPointMake(14, (statusBarSize.height - frame.size.height)/2);
            view.frame = frame;
            view.layer.mask = CAMaskLayerWithSizeAndCorner(view.bounds.size, 0.5*height);
        } else {
            const CGFloat width = 72;
            const CGFloat quarter = height/4;
            CGRect frame = CGRectMake((statusBarSize.width - width)/2, 0, width, height);
            view.frame = frame;
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointZero];
            [path addLineToPoint:CGPointMake(0, quarter)];
            [path addQuadCurveToPoint:CGPointMake(3*quarter, 4*quarter) controlPoint:CGPointMake(0, 4*quarter)];
            CGPoint po = CGPointMake(width - 3*quarter, 4*quarter);
            [path addLineToPoint:po];
            [path addQuadCurveToPoint:CGPointMake(width, 1*quarter) controlPoint:CGPointMake(width, 4*quarter)];
            [path addLineToPoint:CGPointMake(width, 0)];
            [path closePath];
            layer.path = path.CGPath;
            view.layer.mask = layer;
            
        }
        progressLayer = [CALayer layer];
        progressLayer.backgroundColor = [UIColor md_blue].light.CGColor;
        progressLayer.frame = view.bounds;
        [view.layer addSublayer:progressLayer];
        [getSystemStatusBar() addSubview:view];
        
    });
    return view;
}

static inline void updateStatusBarProgress(CGFloat progress){
    UIColor *color = getStatusBarProgressMessageContentView().backgroundColor;
    if (!color) {
        color = [UIColor md_blue].light;
    }
    progressLayer.backgroundColor = color.darkRatio(0.2).CGColor;
    CGRect frame = getStatusBarProgressMessageContentView().bounds;
    CGFloat width = progress * frame.size.width;
    frame.size.width = width;
    progressLayer.frame = frame;
}

/**
 隐藏状态栏消息
 */
static inline void hideStatusBarMessage(){
    [UIView animateWithDuration:0.38f animations:^{
        getStatusBarMessageContentView().alpha = 0;
    } completion:^(BOOL finished) {
        isStatusMessageShowing = NO;
        [getStatusBarMessageContentView() removeFromSuperview];
    }];
}
static inline void hideStatusBarProgressMessage(){
    
    [UIView animateWithDuration:0.58f delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseOut animations:^{
        if (CGConstGetScreenSizeEnum() == kCGScreenSizeEnum_5_8) {
            getStatusBarProgressMessageContentView().alpha = 0;
            getStatusBarProgressMessageContentView().transform = CGAffineTransformMakeScale(1.2, 1.2);
        } else {
            getStatusBarProgressMessageContentView().transform = CGAffineTransformMakeTranslation(0, -20);
        }
    } completion:^(BOOL finished) {
        isStatusProgressMessageShowing = NO;
        [getStatusBarProgressMessageContentView() removeFromSuperview];
        updateStatusBarProgress(0);
    }];
    
}
/**
 显示状态栏消息
 
 @param duration 持续时间
 */
static inline void showStatusBarMessageView(NSTimeInterval duration){
    // 显示
    if (!isStatusMessageShowing) {
        isStatusMessageShowing = YES;
        getStatusBarMessageContentView().alpha = 0;
        [getSystemStatusBar() addSubview:getStatusBarMessageContentView()];
        [UIView animateWithDuration:0.38f animations:^{
            getStatusBarMessageContentView().alpha = 1;
        }];
    }
    // 超时自动消失
    static ax_dispatch_operation_t timeoutToken;
    ax_dispatch_cancel_operation(timeoutToken);
    timeoutToken = ax_dispatch_cancellable(duration, dispatch_get_main_queue(), ^{
        hideStatusBarMessage();
    });
}

static inline void showStatusBarProgressMessageView(NSTimeInterval duration){
    // 显示
    if (!isStatusProgressMessageShowing) {
        isStatusProgressMessageShowing = YES;
        [getSystemStatusBar() addSubview:getStatusBarProgressMessageContentView()];
        if (CGConstGetScreenSizeEnum() == kCGScreenSizeEnum_5_8) {
            getStatusBarProgressMessageContentView().alpha = 0;
            getStatusBarProgressMessageContentView().transform = CGAffineTransformMakeScale(1.2, 1.2);
            [UIView animateWithDuration:0.58f delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseOut animations:^{
                getStatusBarProgressMessageContentView().alpha = 1;
                getStatusBarProgressMessageContentView().transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        } else {
            getStatusBarProgressMessageContentView().transform = CGAffineTransformMakeTranslation(0, -20);
            [UIView animateWithDuration:0.38f delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseOut animations:^{
                getStatusBarProgressMessageContentView().transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }
    // 超时自动消失
    static ax_dispatch_operation_t timeoutToken;
    ax_dispatch_cancel_operation(timeoutToken);
    timeoutToken = ax_dispatch_cancellable(duration, dispatch_get_main_queue(), ^{
        hideStatusBarProgressMessage();
    });
}


/**
 获取状态栏消息label
 
 @param text 消息文本
 @return 状态栏消息label
 */
static inline UILabel *getStatusBarMessageLabel(NSString *text){
    static UILabel *label;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        label = [[UILabel alloc] initWithFrame:getSystemStatusBar().bounds];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12];
        [getStatusBarMessageContentView() addSubview:label];
    });
    label.text = text;
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.size.height = 20;
    frame.origin.x = 6;
    frame.origin.y = getStatusBarMessageContentView().bounds.size.height - 20;
    label.frame = frame;
    CGFloat offset = 2 * frame.origin.x + frame.size.width - getSystemStatusBar().bounds.size.width;
    
    // label滚动动画
    [label.layer removeAllAnimations];
    if (offset > 0) {
        // 需要滚动显示
        static CABasicAnimation *animation;
        animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.repeatDuration = HUGE_VALF;
        animation.toValue = @(-offset);
        animation.autoreverses = YES;
        animation.duration = offset/40.0f;
        
        static ax_dispatch_operation_t animationToken;
        ax_dispatch_cancel_operation(animationToken);
        animationToken = ax_dispatch_cancellable(0.38f, dispatch_get_main_queue(), ^{
            [label.layer addAnimation:animation forKey:nil];
        });
        
    }
    
    return label;
}
static inline UILabel *getStatusBarProgressMessageLabel(NSString *text){
    static UILabel *label;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        label = [[UILabel alloc] init];
        CGRect contentBounds = getStatusBarProgressMessageContentView().bounds;
        CGRect frame = contentBounds;
        
        if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)) {
            frame.size.height = 14;
            frame.origin.y = (contentBounds.size.height - frame.size.height)/2;
            label.font = [UIFont boldSystemFontOfSize:15];
        } else {
            frame.size.height = 20;
            label.font = [UIFont boldSystemFontOfSize:12];
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = frame;
        [getStatusBarProgressMessageContentView() addSubview:label];
    });
    label.text = text;
    
    return label;
}


@implementation AXStatusBar


#pragma mark - 状态栏

/**
 获取状态栏（如果要自定义状态栏，建议使用+[ax_getCustomStatusBar]）
 
 @return 系统状态栏
 */
+ (UIView *)getSystemStatusBar{
    return getSystemStatusBar();
}

/**
 获取可自定义的状态栏
 
 @return 自定义状态栏
 */
+ (UIView *)getCustomStatusBar{
    return getCustomStatusBar();
}



#pragma mark - 状态栏消息（长文本）

/**
 显示状态栏消息，显示区域为整个状态栏。
 可显示长文本，超出屏幕部分会滚动显示。
 
 @param message 消息内容
 @param textColor 文本颜色
 @param backgroundColor 背景颜色
 @param duration 持续时间
 
 @return 消息标签
 */
+ (UILabel *)showStatusBarMessage:(NSString *)message textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor duration:(NSTimeInterval)duration{
    UIView *contentView = getStatusBarMessageContentView();
    contentView.backgroundColor = backgroundColor;
    UILabel *label = getStatusBarMessageLabel(message);
    label.textColor = textColor;
    showStatusBarMessageView(duration);
    return label;
}

+ (void)hideStatusBarMessage{
    hideStatusBarMessage();
}



#pragma mark - 状态栏消息（6个字符以内）

/**
 显示状态栏消息，显示区域为系统时间的位置。
 超过6个字符则以长文本的显示逻辑执行。
 
 @param message 消息内容
 @param textColor 文本颜色
 @param backgroundColor 背景颜色
 @param duration 持续时间
 
 @return 消息标签
 */
+ (UILabel *)showStatusBarProgress:(CGFloat)progress textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor duration:(NSTimeInterval)duration{
    UIView *contentView = getStatusBarProgressMessageContentView();
    contentView.backgroundColor = backgroundColor;
    NSString *message;
    message = [NSString stringWithFormat:@"%.0f%%", 100 * progress];
    UILabel *label = getStatusBarProgressMessageLabel(message);
    label.textColor = textColor;
    updateStatusBarProgress(progress);
    showStatusBarProgressMessageView(duration);
    return label;
}


+ (void)hideStatusBarProgressMessage{
    hideStatusBarProgressMessage();
}


@end
