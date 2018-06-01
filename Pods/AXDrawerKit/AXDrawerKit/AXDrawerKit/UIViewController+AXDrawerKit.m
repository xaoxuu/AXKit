//
//  UIViewController+AXDrawerKit.m
//  AXKit
//
//  Created by xaoxuu on 2018/4/8.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "UIViewController+AXDrawerKit.h"


// ==================== [ parameters ] ==================== //

static CGFloat sScale = 1.0f;
static CGFloat sRightLimit = 60.0f;
static CGFloat sLeftLimit = 80.0f;
static CGFloat sLeftRatio = 0.3f;

// screen
static CGFloat sScreenWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}

static CGPoint sScreenCenter(){
    return CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
}

static CGFloat sScreenCenterXOpened(){
    return sScreenCenter().x+sScreenWidth()-sRightLimit;
}

// ==================== [ variable ] ==================== //
static UIViewController *sMainVC = nil;
static UIViewController *sDrawerVC = nil;
static UIPanGestureRecognizer *sPan = nil;
static BOOL sLeftViewOpen = NO;
static BOOL sEnable = YES;


@implementation UIViewController (AXDrawerKit)


- (void)at_setupMainVC:(nonnull UIViewController *)mainVC drawerVC:(nonnull UIViewController *)drawerVC enable:(BOOL)enable{
    
    if (mainVC&&drawerVC){
        
        // ==================== [ setup controllers ] ==================== //
        sDrawerVC = drawerVC;
        // add child view controller
        [self addChildViewController:drawerVC];
        // add subview
        [self.view addSubview:drawerVC.view];
        
        sMainVC = mainVC;
        // add child view controller
        [self addChildViewController:mainVC];
        // add subview
        [self.view addSubview:mainVC.view];
        
        
        // ==================== [ setup controllers ] ==================== //
        if (enable) {
            [self setupPanGesture];
        }
        
    }
    else{
        // show alert
        [self performSelector:@selector(showAlert) withObject:nil afterDelay:0.3];
    }
}


- (void)at_disableGeatureInChlidController{
    if (self.navigationController.viewControllers.count == 1) {
        // root view controller
        self.enableGesture = YES;
    } else{
        // not root view controller
        self.enableGesture = NO;
    }
}



#pragma mark - setting methods

- (UIViewController * _Nonnull (^)(CGFloat))scale{
    return ^(CGFloat scale){
        sScale = scale;
        return self;
    };
}

- (UIViewController * _Nonnull (^)(CGFloat))rightLimit{
    return ^(CGFloat limit){
        sRightLimit = limit;
        return self;
    };
}

- (UIViewController * _Nonnull (^)(CGFloat))leftLimit{
    return ^(CGFloat limit){
        sLeftLimit = limit;
        return self;
    };
}

- (UIViewController * _Nonnull (^)(CGFloat))leftRatio{
    return ^(CGFloat ratio){
        sLeftRatio = ratio;
        return self;
    };
}



#pragma mark - private methods


// add pan gesture
- (void)setupPanGesture {
    
    sPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:sPan];
    
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)sender{
    
    // ==================== [ filter ] ==================== //
    if (!sEnable) {
        return;
    }
    const CGFloat translationX = [sender translationInView:self.view].x;
    const CGFloat velocityX = [sender velocityInView:self.view].x;
    // ==================== [ sliding... ] ==================== //
    // touch point moved
    if (sender && sender.state == UIGestureRecognizerStateChanged) {
        
        if (sMainVC.view.center.x < sScreenCenter().x) {
            // move left
            [self moveLeftWithTranslationX:translationX];
        } else {
            // move right
            [self moveRightWithTranslationX:translationX];
        }
        
    }
    // touch up
    if (sender && sender.state == UIGestureRecognizerStateRecognized) {
        
        // open or close drawer vc depend on velocityX
        if (fabs(velocityX)>500) {
            [self openDrawerViewIf:velocityX > 500];
        } else {
            // open or close drawer vc depend on location
            const CGFloat leftDistance  = fabs(sMainVC.view.center.x-sScreenCenter().x);
            const CGFloat rightDistance = fabs(sMainVC.view.center.x-sScreenCenterXOpened());
            [self openDrawerViewIf:leftDistance > rightDistance];
        }
        
    }
    
    
}

// move left
- (void)moveLeftWithTranslationX:(CGFloat)translationX{
    
    // max offset equal to sLeftLimit
    if (sMainVC.view.center.x >= sScreenCenter().x - sLeftLimit) {
        sMainVC.view.center = [self offsetX:sLeftRatio * translationX fromOriginX:0];
    }
    
}
// move right
- (void)moveRightWithTranslationX:(CGFloat)translationX{
    
    // max offset equal to screen width or more
    if (sMainVC.view.center.x <= 4*sScreenCenter().x) {
        // when drawer view is open
        if (sLeftViewOpen) {
            // main view move
            sMainVC.view.center = [self offsetX:translationX fromOriginX:sScreenWidth()-sRightLimit];
            // drawer view move
            sDrawerVC.view.center = [self offsetX:translationX*sLeftLimit/sScreenWidth() fromOriginX:0];
        }
        // when drawer view is close
        else {
            // main view move
            sMainVC.view.center = [self offsetX:translationX fromOriginX:0];
            // drawer view move
            sDrawerVC.view.center = [self offsetX:translationX*sLeftLimit/sScreenWidth() fromOriginX:-sLeftLimit];
        }
    }
    
}

// move 'offset' from 'origin'
- (CGPoint)offsetX:(CGFloat)offset fromOriginX:(CGFloat)origin{
    
    const CGFloat newScreenX = sScreenCenter().x + origin + offset;
    
    return CGPointMake(newScreenX, sScreenCenter().y);
}


// open or close drawer view
- (void)openDrawerViewIf:(BOOL)open{
    [UIView animateWithDuration:0.48 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
        sMainVC.view.center = CGPointMake(open ? sScreenCenterXOpened():sScreenCenter().x, sScreenCenter().y);
        sDrawerVC.view.center = CGPointMake(open ? sScreenCenter().x:(sScreenCenter().x - sLeftLimit), sScreenCenter().y);
    } completion:^(BOOL finished) {
        sLeftViewOpen = open;
    }];
}

#pragma mark warning

// show alert
- (void)showAlert{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告⚠️" message:@"主视图控制器或左侧抽屉视图控制器不能为空!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        NSLog(@"警告⚠️: 主视图控制器或左侧抽屉视图控制器不能为空!");
    });
}


#pragma mark static property

- (BOOL)enableGesture{
    return sEnable;
}

- (void)setEnableGesture:(BOOL)enableGesture{
    sEnable = enableGesture;
}


@end
