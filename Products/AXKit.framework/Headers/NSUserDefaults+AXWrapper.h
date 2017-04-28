//
//  NSUserDefaults+AXWrapper.h
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSUserDefaults (AXWrapper)

#pragma mark read


/**
 读取用户设置

 @param key 键
 @return 值
 */
+ (BOOL)ax_readUserDefaultBoolWithKey:(NSString *)key;

/**
 读取用户设置

 @param key 键
 @return 值
 */
+ (nullable id)ax_readUserDefaultValueWithKey:(NSString *)key;


#pragma mark write

/**
 批量保存用户设置，自带synchronize

 @param action 批量保存用户设置的block
 */
+ (void)ax_caches:(void (^)(NSUserDefaults *defaultUser))action;

/**
 保存用户设置，自带synchronize
 
 @param obj   值
 @param key   键
 */
+ (void)ax_cacheObject:(nullable id)obj key:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param value 值
 @param key   键
 */
+ (void)ax_cacheValue:(nullable id)value key:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_cacheBool:(BOOL)x key:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_cacheInteger:(NSInteger)x key:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_cacheFloat:(float)x key:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_cacheDouble:(double)x key:(NSString *)key;



/**
 保存用户设置，不带synchronize
 
 @param obj 值
 @param key 键
 */
- (void)ax_cacheObject:(nullable id)obj key:(NSString *)key;

/**
 保存用户设置，不带synchronize

 @param value 值
 @param key 键
 */
- (void)ax_cacheValue:(nullable id)value key:(NSString *)key;

/**
 保存用户设置，不带synchronize

 @param x 值
 @param key 键
 */
- (void)ax_cacheBool:(BOOL)x key:(NSString *)key;

/**
 保存用户设置，不带synchronize

 @param x 值
 @param key 键
 */
- (void)ax_cacheInteger:(NSInteger)x key:(NSString *)key;

/**
 保存用户设置，不带synchronize

 @param x 值
 @param key 键
 */
- (void)ax_cacheFloat:(float)x key:(NSString *)key;

/**
 保存用户设置，不带synchronize

 @param x 值
 @param key 键
 */
- (void)ax_cacheDouble:(double)x key:(NSString *)key;

#pragma mark remove


/**
 删除用户设置，自带synchronize

 @param key 键
 */
+ (void)ax_removeObjectForKey:(NSString *)key;

/**
 删除用户设置，不带synchronize

 @param key 键
 */
- (void)ax_removeObjectForKey:(NSString *)key;


@end

@interface NSString (CacheUserDefaults)

/**
 快速读取用户设置，调用者为键

 @return 值
 */
- (id)readUserDefaultValue;

/**
 快速读取用户设置，调用者为键

 @return 值
 */
- (BOOL)readUserDefaultBool;

/**
 快速保存用户设置，调用者为键
 */
- (NSString *(^)(id))cacheUserDefaultValue;

/**
 快速保存用户设置，调用者为键
 */
- (NSString *(^)(BOOL))cacheUserDefaultBool;


@end

NS_ASSUME_NONNULL_END
