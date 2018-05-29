//
//  AppDelegate.m
//  AXKitDemo
//
//  Created by ayan on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "AXFeedbackKit.h"


@interface AppDelegate ()

// @xaoxuu: root vc
@property (strong, nonatomic) RootViewController *rootVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // @xaoxuu: 配置主题
    [[UIThemeManager sharedInstance] configDefaultTheme:^(UIThemeManager *theme) {
        theme.color.theme = [UIColor ax_blue];
        theme.color.accent = [UIColor md_lime];
    }];
    
    [[EmailManager sharedInstance] configDefaultCompose:^(EmailManager *manager) {
        manager.defaultToRecipients = @[@"me@xaoxuu.com"];
    }];
    // @xaoxuu: 激活服务
    [ServiceLayer sharedInstance];
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置窗口根控制器
    self.rootVC = [[RootViewController alloc] init];
    self.window.rootViewController = self.rootVC;
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    AXCachedLogOBJ(application);
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    AXCachedLogOBJ(application);
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    AXCachedLogOBJ(application);
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    AXCachedLogOBJ(application);
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    AXCachedLogOBJ(application);
}


@end
