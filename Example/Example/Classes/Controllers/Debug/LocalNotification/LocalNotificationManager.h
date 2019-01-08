//
//  LocalNotificationManager.h
//  AXKitDemo
//
//  Created by xaoxuu on 29/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationManager : NSObject
+ (void)prepare;

+ (void)pushNotificationWithTimeInterval:(NSTimeInterval)timeInterval message:(NSString *)message;
+ (void)pushNotificationWithDateComponents:(void (^)(NSDateComponents *components))components message:(NSString *)message;

@end
