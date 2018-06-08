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

/**
 standardUserDefaults

 @return standardUserDefaults
 */
+ (NSUserDefaults *)standard;

#pragma mark - read

/**
 读取object
 */
+ (nullable AXResult *(^)(NSString *key))objectResult;
/**
 读取object
 */
- (nullable AXResult *(^)(NSString *key))objectResult;

/**
 读取object
 */
+ (nullable id (^)(NSString *key))objectForKey;
/**
 读取object
 */
- (nullable id (^)(NSString *key))objectForKey;

/**
 读取string
 */
+ (nullable NSString *(^)(NSString *key))string;
/**
 读取string
 */
- (nullable NSString *(^)(NSString *key))string;

/**
 读取number
 */
+ (nullable NSNumber *(^)(NSString *key))number;
/**
 读取number
 */
- (nullable NSNumber *(^)(NSString *key))number;

/**
 读取array
 */
+ (nullable NSArray *(^)(NSString *key))array;
/**
 读取array
 */
- (nullable NSArray *(^)(NSString *key))array;

/**
 读取dictionary
 */
+ (nullable NSDictionary *(^)(NSString *key))dictionary;
/**
 读取dictionary
 */
- (nullable NSDictionary *(^)(NSString *key))dictionary;

/**
 读取data
 */
+ (nullable NSData *(^)(NSString *key))data;
/**
 读取data
 */
- (nullable NSData *(^)(NSString *key))data;

/**
 读取image
 */
+ (nullable UIImage *(^)(NSString *key))image;
/**
 读取image
 */
- (nullable UIImage *(^)(NSString *key))image;

/**
 读取URL
 */
+ (nullable NSURL *(^)(NSString *key))URL;
/**
 读取URL
 */
- (nullable NSURL *(^)(NSString *key))URL;


#pragma mark - write

/**
 保存
 */
+ (void (^)(id __nullable obj, NSString *key))setObjectForKey;

/**
 保存
 */
- (void (^)(id __nullable obj, NSString *key))setObjectForKey;

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
+ (void (^)(NSString *key))removeObjectForKey;
/**
 删除用户设置，自带synchronize
 */
- (void (^)(NSString *key))removeObjectForKey;

+ (void (^)(NSString *name))removePersistentDomainForName;

- (void (^)(NSString *name))removePersistentDomainForName;

/**
 移除默认的[NSUserDefaults standardUserDefaults]的所有配置
 */
+ (void (^)(void))removeDefaultPersistentDomain;
/**
 移除默认的[NSUserDefaults standardUserDefaults]的所有配置
 */
- (void (^)(void))removeDefaultPersistentDomain;


@end

NS_ASSUME_NONNULL_END
