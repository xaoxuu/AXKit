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
    [[AXThemeManager sharedInstance] configDefaultTheme:^(AXThemeManager *theme) {
        theme.color.theme = [UIColor ax_blue];//82,161,248
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
    
    [self test];
    
    return YES;
}

- (void)test{
    NSArray *a1 = @[@"i0", @"i1", @"i2"];
    NSDictionary *d1 = @{@"aa": a1, @"bb":@"haha"};
    
//    NSDictionary *aa = NSDictionary.safe2(d1);
//    NSDictionary *aa2 = NSDictionary.safe2(d1, @{@"k":@"def"});
    
//    NSDictionary *rd1 = NSDictionary.safe(a1);
//    NSDictionary *rd2 = NSDictionary.safe(a1, @2, @{@"k":@"def"});
//    NSDictionary *rd3 = NSDictionary.safe(a1, @{@"k":@"def"});
//    NSDictionary *rd4 = NSDictionary.safe(a1, @{@"a":@"aa"}, @{@"k":@"def"});
//    NSDictionary *rd5 = NSDictionary.safe(d1, @{@"a":@"aa"}, @{@"k":@"def"});
//    NSDictionary *rd6 = NSDictionary.safe(a1, nil, d1);
//    NSDictionary *rd7 = NSDictionary.safe(nil, d1);
    
    NSData *data = [NSData dataWithHexString:@"0x2f"];
    NSData *data2 = d1.toJson().dataValue;
    NSData *data3 = [@"data string" dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *rs4 = NSString.safe(nil);
//    NSString *rs1 = NSString.safe(a1);
//    NSString *rs2 = NSString.safe(d1);
//    NSString *rs3 = NSString.safe(@2333);
//    NSString *rs5 = NSString.safe(data);
//    NSString *rs6 = NSString.safe(data2);
//    NSString *rs7 = NSString.safe(data3);
//
//    NSNumber *rn1 = NSNumber.safe(@"233");
//    NSNumber *rn2 = NSNumber.safe(nil);

//    NSDictionary *bb3 = [NSDictionary testSafe:a1,@{@"k":@"def"}];
//    NSDictionary *aa3 = [NSDictionary testSafe:a1];
    
//    NSNumber.safe(d1[@"type"]).intValue;
//    NSNumber.safeValue(d1[@"type"], @(-1)).intValue;
//    (NSNumber.safe(d1[@"type"]) ?: @0).intValue;
//    NSString.parse(@"", nil);
//
//    NSString.safe(d1[@"name"]);
//    NSString.safe(d1[@"name"], @"default name");
//    [NSString ax_safeString:d1[@"name"]];
//    [NSString ax_safeString:d1[@"name"] defaultString:@"default name"];
//    NSString.strict();
    NSData *data1 = d1.toJson().dataValue;
    NSString *str1 = d1.toJson().stringValue;
    NSString *str2 = @"2333";
    
    AXResult *r1 = a1.toJson();
    AXResult *r2 = d1.toJson();
    AXResult *r3 = data1.toJson();
    AXResult *r4 = str1.toJson();
    AXResult *r5 = str2.toJson();
    
    
    
    [str2.toJson() numberValue:^(NSNumber * _Nonnull numberValue) {
        AXLogOBJ(numberValue);
    }];
    [[@"a1".docPath.saveJson(a1) error:^(NSError * _Nullable error) {
        AXLogError(error);
    }] completed:^(BOOL success) {
        
    }];
    [@"d1".docPath.saveJson(d1) error:^(NSError * _Nullable error) {
        AXLogError(error);
    }];
    
    id readS1 = @"s1".docPath.readJsonResult();
    AXLogOBJ(readS1);
    
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
