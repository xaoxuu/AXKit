//
//  LocalNotificationManager.m
//  AXKitDemo
//
//  Created by xaoxuu on 29/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "LocalNotificationManager.h"
#import <UserNotifications/UserNotifications.h>



static inline void pushNotification(UNNotificationTrigger *trigger, void (^notificationContent)(UNMutableNotificationContent *content)){
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted) {
                NSLog(@"授权成功");
            }
        }];
    });
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.sound = [UNNotificationSound defaultSound];
    content.title = @"title";
    content.subtitle = @"subtitle";
    content.body = @"body";
    if (notificationContent) {
        notificationContent(content);
    }
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:content.body content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        AXLogError(error);
    }];
}

static inline void pushNotificationWithTimeInterval(NSTimeInterval timeInterval, void (^notificationContent)(UNMutableNotificationContent *content)){
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:NO];
    pushNotification(trigger, notificationContent);
}

@implementation LocalNotificationManager

+ (void)prepare{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:UNAuthorizationOptionNone completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(granted) {
            NSLog(@"授权成功");
        }
    }];
    
}

+ (void)pushNotificationWithTimeInterval:(NSTimeInterval)timeInterval message:(NSString *)message{
    pushNotificationWithTimeInterval(timeInterval, ^(UNMutableNotificationContent *content) {
        content.body = message;
    });
    
}

+ (void)pushNotificationWithDateComponents:(void (^)(NSDateComponents *))components message:(NSString *)message{
    NSDateComponents *com = [[NSDateComponents alloc] init];
    if (components) {
        components(com);
    }
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:com repeats:YES];
    pushNotification(trigger, ^(UNMutableNotificationContent *content) {
        content.body = message;
    });
}




@end
