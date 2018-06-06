//
//  NSUserDefaults+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSUserDefaults (AXAdd)

#pragma mark - read


/**
 读取object值（不推荐）

 @param key 键
 @return 值
 */
+ (nullable id)ax_readObjectForKey:(NSString *)key;

/**
 读取object值（推荐）
 
 @param key 键
 @param completion 读取成功
 @param failure 读取失败（没有值）
 */
+ (void)ax_readObjectForKey:(NSString *)key completion:(void (^)(id object))completion failure:(void (^)(NSError *error))failure;

/**
 读取BOOL值
 
 @param key 键
 @return 值
 */
+ (BOOL)ax_readBoolForKey:(NSString *)key;

/**
 读取NSInteger值
 
 @param key 键
 @return 值
 */
+ (NSInteger)ax_readIntegerForKey:(NSString *)key;

/**
 读取float值
 
 @param key 键
 @return 值
 */
+ (float)ax_readFloatForKey:(NSString *)key;

/**
 读取double值
 
 @param key 键
 @return 值
 */
+ (double)ax_readDoubleForKey:(NSString *)key;

/**
 读取CGFloat值
 
 @param key 键
 @return 值
 */
+ (CGFloat)ax_readCGFloatForKey:(NSString *)key;


/**
 读取NSData值（不推荐）
 
 @param key 键
 @return 值
 */
+ (nullable NSData *)ax_readDataForKey:(NSString *)key;

/**
 读取NSData值（推荐）

 @param key 键
 @param completion 读取成功
 @param failure 读取失败（没有值）
 */
+ (void)ax_readDataForKey:(NSString *)key completion:(void (^)(NSData *data))completion failure:(void (^)(NSError *error))failure;

/**
 读取NSString值（不推荐）
 
 @param key 键
 @return 值
 */
+ (nullable NSString *)ax_readStringForKey:(NSString *)key;

/**
 读取NSString值（推荐）
 
 @param key 键
 @param completion 读取成功
 @param failure 读取失败（没有值）
 */
+ (void)ax_readStringForKey:(NSString *)key completion:(void (^)(NSString *string))completion failure:(void (^)(NSError *error))failure;

/**
 读取NSArray值（不推荐）
 
 @param key 键
 @return 值
 */
+ (nullable NSArray *)ax_readArrayForKey:(NSString *)key;

/**
 读取NSArray值（推荐）
 
 @param key 键
 @param completion 读取成功
 @param failure 读取失败（没有值）
 */
+ (void)ax_readArrayForKey:(NSString *)key completion:(void (^)(NSArray *array))completion failure:(void (^)(NSError *error))failure;

/**
 读取NSDictionary值（不推荐）
 
 @param key 键
 @return 值
 */
+ (nullable NSDictionary<NSString *, id> *)ax_readDictionaryForKey:(NSString *)key;

/**
 读取NSDictionary值（推荐）
 
 @param key 键
 @param completion 读取成功
 @param failure 读取失败（没有值）
 */
+ (void)ax_readDictionaryForKey:(NSString *)key completion:(void (^)(NSDictionary *dictionary))completion failure:(void (^)(NSError *error))failure;

/**
 读取若干字符串值，并组装成NSDictionary

 @param keys 键
 @return 值
 */
+ (NSDictionary<NSString *, id> *)ax_readDictionaryWithValuesForKeys:(NSArray<NSString *> *)keys;

/**
 读取URL值（不推荐）
 
 @param key 键
 @return 值
 */
+ (nullable NSURL *)ax_readURLForKey:(NSString *)key;

/**
 读取NSURL值（推荐）
 
 @param key 键
 @param completion 读取成功
 @param failure 读取失败（没有值）
 */
+ (void)ax_readURLForKey:(NSString *)key completion:(void (^)(NSURL *url))completion failure:(void (^)(NSError *error))failure;


/**
 读取图片（不推荐）

 @param key 键
 @return 值
 */
+ (nullable UIImage *)ax_readImageForKey:(NSString *)key;

/**
 读取图片（推荐）
 
 @param key 键
 @param completion 读取成功
 @param failure 读取失败（没有值）
 */
+ (void)ax_readImageForKey:(NSString *)key completion:(void (^)(UIImage *image))completion failure:(void (^)(NSError *error))failure;

#pragma mark - write

/**
 批量保存用户设置，自带synchronize

 @param action 批量保存用户设置的block
 */
+ (void)ax_caches:(void (^)(NSUserDefaults *defaultUser))action;

/**
 保存id对象，自带synchronize
 
 @param obj   值
 @param key   键
 */
+ (void)ax_setObject:(nullable id)obj forKey:(NSString *)key;

/**
 保存value，自带synchronize

 @param value 值
 @param key   键
 */
+ (void)ax_setValue:(nullable id)value forKey:(NSString *)key;

/**
 保存BOOL值，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_setBool:(BOOL)x forKey:(NSString *)key;

/**
 保存NSInteger，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_setInteger:(NSInteger)x forKey:(NSString *)key;

/**
 保存float，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_setFloat:(float)x forKey:(NSString *)key;

/**
 保存double，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_setDouble:(double)x forKey:(NSString *)key;

/**
 保存CGFloat，自带synchronize
 
 @param x 值
 @param key 键
 */
+ (void)ax_setCGFloat:(CGFloat)x forKey:(NSString *)key;

/**
 保存NSData，自带synchronize
 
 @param data 值
 @param key 键
 */
+ (void)ax_setData:(nullable NSData *)data forKey:(NSString *)key;

/**
 保存字符串，自带synchronize
 
 @param string 值
 @param key 键
 */
+ (void)ax_setString:(nullable NSString *)string forKey:(NSString *)key;

/**
 保存数组，自带synchronize
 
 @param arr 值
 @param key 键
 */
+ (void)ax_setArray:(nullable NSArray *)arr forKey:(NSString *)key;

/**
 保存字典，自带synchronize
 
 @param dict 值
 @param key 键
 */
+ (void)ax_setDictionary:(nullable NSDictionary *)dict forKey:(NSString *)key;
/**
 保存NSURL，自带synchronize
 
 @param url 值
 @param key 键
 */
+ (void)ax_setURL:(nullable NSURL *)url forKey:(NSString *)key;


/**
 保存图片，自带synchronize
 
 @param image 图片
 @param key 键
 */
+ (void)ax_setImage:(nullable UIImage *)image forKey:(NSString *)key;


/**
 批量保存用户设置，自带synchronize

 @param action 批量保存用户设置的block
 */
- (void)ax_caches:(void (^)(NSUserDefaults *user))action;

/**
 保存NSData，不带synchronize
 
 @param data 值
 @param key 键
 */
- (void)ax_setData:(nullable NSData *)data forKey:(NSString *)key;

/**
 保存字符串，不带synchronize
 
 @param string 值
 @param key 键
 */
- (void)ax_setString:(nullable NSString *)string forKey:(NSString *)key;

/**
 保存数组，不带synchronize
 
 @param arr 值
 @param key 键
 */
- (void)ax_setArray:(nullable NSArray *)arr forKey:(NSString *)key;

/**
 保存字典，不带synchronize
 
 @param dict 值
 @param key 键
 */
- (void)ax_setDictionary:(nullable NSDictionary *)dict forKey:(NSString *)key;

/**
 保存NSURL，不带synchronize
 
 @param url 值
 @param key 键
 */
- (void)ax_setURL:(nullable NSURL *)url forKey:(NSString *)key;




#pragma mark - remove


/**
 删除用户设置，自带synchronize

 @param key 键
 */
+ (void)ax_removeObjectForKey:(NSString *)key;


/**
 移除默认的[NSUserDefaults standardUserDefaults]的所有配置
 */
+ (void)ax_removeDefaultPersistentDomain;


@end

NS_ASSUME_NONNULL_END
