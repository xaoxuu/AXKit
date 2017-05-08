//
//  NSUserDefaults+AXWrapper.h
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSUserDefaults (AXWrapper)

#pragma mark read


/**
 读取object值

 @param key 键
 @return 值
 */
+ (nullable id)ax_readObjectForKey:(NSString *)key;

/**
 读取object值
 
 @param key 键
 @param completion 读取成功
 @param fail 读取失败（没有值）
 */
+ (void)ax_readObjectForKey:(NSString *)key completion:(void (^)(id))completion fail:(void (^)(NSError *))fail;

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
 读取NSData值
 
 @param key 键
 @return 值
 */
+ (nullable NSData *)ax_readDataForKey:(NSString *)key;

/**
 读取NSData值

 @param key 键
 @param completion 读取成功
 @param fail 读取失败（没有值）
 */
+ (void)ax_readDataForKey:(NSString *)key completion:(void (^)(NSData *))completion fail:(void (^)(NSError *))fail;

/**
 读取NSString值
 
 @param key 键
 @return 值
 */
+ (nullable NSString *)ax_readStringForKey:(NSString *)key;

/**
 读取NSString值
 
 @param key 键
 @param completion 读取成功
 @param fail 读取失败（没有值）
 */
+ (void)ax_readStringForKey:(NSString *)key completion:(void (^)(NSString *))completion fail:(void (^)(NSError *))fail;

/**
 读取字符串数组
 
 @param key 键
 @return 值
 */
+ (nullable NSArray<NSString *> *)ax_readStringArrayForKey:(NSString *)key;

/**
 读取字符串数组
 
 @param key 键
 @param completion 读取成功
 @param fail 读取失败（没有值）
 */
+ (void)ax_readStringArrayForKey:(NSString *)key completion:(void (^)(NSArray<NSString *> *))completion fail:(void (^)(NSError *))fail;

/**
 读取NSArray值
 
 @param key 键
 @return 值
 */
+ (nullable NSArray *)ax_readArrayForKey:(NSString *)key;

/**
 读取NSArray值
 
 @param key 键
 @param completion 读取成功
 @param fail 读取失败（没有值）
 */
+ (void)ax_readArrayForKey:(NSString *)key completion:(void (^)(NSArray *))completion fail:(void (^)(NSError *))fail;

/**
 读取NSDictionary值
 
 @param key 键
 @return 值
 */
+ (nullable NSDictionary<NSString *, id> *)ax_readDictionaryForKey:(NSString *)key;

/**
 读取NSDictionary值
 
 @param key 键
 @param completion 读取成功
 @param fail 读取失败（没有值）
 */
+ (void)ax_readDictionaryForKey:(NSString *)key completion:(void (^)(NSDictionary *))completion fail:(void (^)(NSError *))fail;

/**
 读取若干字符串值，并组装成NSDictionary

 @param keys 键
 @return 值
 */
+ (NSDictionary<NSString *, id> *)ax_readDictionaryWithValuesForKeys:(NSArray<NSString *> *)keys;

/**
 读取URL值
 
 @param key 键
 @return 值
 */
+ (nullable NSURL *)ax_readURLForKey:(NSString *)key;

/**
 读取NSURL值
 
 @param key 键
 @param completion 读取成功
 @param fail 读取失败（没有值）
 */
+ (void)ax_readURLForKey:(NSString *)key completion:(void (^)(NSURL *))completion fail:(void (^)(NSError *))fail;



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
+ (void)ax_setObject:(nullable id)obj forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param value 值
 @param key   键
 */
+ (void)ax_setValue:(nullable id)value forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_setBool:(BOOL)x forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_setInteger:(NSInteger)x forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_setFloat:(float)x forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize

 @param x 值
 @param key 键
 */
+ (void)ax_setDouble:(double)x forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize
 
 @param x 值
 @param key 键
 */
+ (void)ax_setCGFloat:(CGFloat)x forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize
 
 @param data 值
 @param key 键
 */
+ (void)ax_setData:(NSData *)data forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize
 
 @param string 值
 @param key 键
 */
+ (void)ax_setString:(NSString *)string forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize
 
 @param stringArray 值
 @param key 键
 */
+ (void)ax_setStringArray:(NSArray<NSString *> *)stringArray forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize
 
 @param array 值
 @param key 键
 */
+ (void)ax_setArray:(NSArray *)array forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize
 
 @param dictionary 值
 @param key 键
 */
+ (void)ax_setDictionary:(NSDictionary<NSString *, id> *)dictionary forKey:(NSString *)key;

/**
 保存用户设置，自带synchronize
 
 @param url 值
 @param key 键
 */
+ (void)ax_setURL:(NSURL *)url forKey:(NSString *)key;


/**
 批量保存用户设置，自带synchronize

 @param action 批量保存用户设置的block
 */
- (void)ax_caches:(void (^)(NSUserDefaults *user))action;

/**
 保存用户设置，不带synchronize
 
 @param data 值
 @param key 键
 */
- (void)ax_setData:(NSData *)data forKey:(NSString *)key;

/**
 保存用户设置，不带synchronize
 
 @param string 值
 @param key 键
 */
- (void)ax_setString:(NSString *)string forKey:(NSString *)key;

/**
 保存用户设置，不带synchronize
 
 @param stringArray 值
 @param key 键
 */
- (void)ax_setStringArray:(NSArray<NSString *> *)stringArray forKey:(NSString *)key;

/**
 保存用户设置，不带synchronize
 
 @param array 值
 @param key 键
 */
- (void)ax_setArray:(NSArray *)array forKey:(NSString *)key;

/**
 保存用户设置，不带synchronize
 
 @param dictionary 值
 @param key 键
 */
- (void)ax_setDictionary:(NSDictionary<NSString *, id> *)dictionary forKey:(NSString *)key;

/**
 保存用户设置，不带synchronize
 
 @param url 值
 @param key 键
 */
- (void)ax_setURL:(NSURL *)url forKey:(NSString *)key;




#pragma mark remove


/**
 删除用户设置，自带synchronize

 @param key 键
 */
+ (void)ax_removeObjectForKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
