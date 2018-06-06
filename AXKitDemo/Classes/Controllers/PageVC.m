//
//  PageVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 2018/6/6.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "PageVC.h"

@interface PageVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@end

@implementation PageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.randomColor;
    self.dataSource = self;
    self.delegate = self;
    
    [self setViewControllers:@[UIViewControllerNamed(@"ShadowVC")] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    return UIViewControllerNamed(@"ShadowVC");
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    return UIViewControllerNamed(@"CooldownVC");
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
//    return 5;
//}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
    return 0;
}


// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0){
    AXLogFunc();
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    AXLogFunc();
    AXLogNSInteger(self.viewControllers.count);
    AXLogNSInteger(self.transitionStyle);
}

// Delegate may specify a different spine location for after the interface orientation change. Only sent for transition style 'UIPageViewControllerTransitionStylePageCurl'.
// Delegate may set new view controllers or update double-sided state within this method's implementation as well.
//- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation __TVOS_PROHIBITED{
//    AXLogFunc();
//
//}
//
//- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED{
//    AXLogFunc();
//}
//- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED{
//    AXLogFunc();
//}


@end
