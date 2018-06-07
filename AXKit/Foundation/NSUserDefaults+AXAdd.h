//
//  NSUserDefaults+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXResult.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSUserDefaults (AXAdd)


#pragma mark - read

/**
 读取object
 */
+ (nullable AXResult *(^)(NSString *key))objectResult;
/**
 读取object
 */
+ (nullable id (^)(NSString *key))object;
/**
 读取string
 */
+ (nullable NSString *(^)(NSString *key))string;
/**
 读取number
 */
+ (nullable NSNumber *(^)(NSString *key))number;
/**
 读取array
 */
+ (nullable NSArray *(^)(NSString *key))array;
/**
 读取dictionary
 */
+ (nullable NSDictionary *(^)(NSString *key))dictionary;
/**
 读取data
 */
+ (nullable NSData *(^)(NSString *key))data;
/**
 读取image
 */
+ (nullable UIImage *(^)(NSString *key))image;


+ (nullable NSURL *(^)(NSString *key))URL;


#pragma mark - write

/**
 保存
 */
+ (void (^)(id __nullable obj, NSString *key))set;

/**
 批量保存用户设置，自带synchronize

 @param action 批量保存用户设置的block
 */
+ (void)ax_caches:(void (^)(NSUserDefaults *defaultUser))action;


/**
 批量保存用户设置，自带synchronize

 @param action 批量保存用户设置的block
 */
- (void)ax_caches:(void (^)(NSUserDefaults *user))action;


#pragma mark - remove

/**
 删除用户设置，自带synchronize
 */
+ (void (^)(NSString *key))remove;

/**
 移除默认的[NSUserDefaults standardUserDefaults]的所有配置
 */
+ (void (^)(void))removeDefaultPersistentDomain;


@end

NS_ASSUME_NONNULL_END
