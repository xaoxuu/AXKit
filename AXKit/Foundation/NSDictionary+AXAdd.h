//
//  NSDictionary+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXResult.h"
NS_ASSUME_NONNULL_BEGIN
@interface NSDictionary (AXAdd)

/**
 根据json字符串创建字典

 @param string json字符串
 @return 字典
 */
+ (nullable instancetype)dictionaryWithJsonString:(NSString *)string;

/**
 解析dictionary中的dictionary，返回值可能为空
 
 @param key 键
 @return 值
 */
- (nullable NSDictionary *)dictionaryValueForKey:(NSString *)key;

/**
 解析dictionary中的array，返回值可能为空
 
 @param key 键
 @return 值
 */
- (nullable NSArray *)arrayValueForKey:(NSString *)key;

/**
 解析dictionary中的string，返回值可能为空
 
 @param key 键
 @return 值
 */
- (nullable NSString *)stringValueForKey:(NSString *)key;

/**
 解析dictionary中的number，返回值可能为空
 
 @param key 键
 @return 值
 */
- (nullable NSNumber *)numberValueForKey:(NSString *)key;

@end
NS_ASSUME_NONNULL_END
