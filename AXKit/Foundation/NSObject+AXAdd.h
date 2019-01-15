//
//  NSObject+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 13/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AXAdd)

/**
 获取所有子类

 @return 所有子类
 */
+ (NSArray *)ax_subclasses;

@end

@interface NSString (AXSafeAdd)

/**
 安全的字符串，如果传入obj不是字符串，但是能够转换成字符串，则返回转换后的字符串
 NSNumber                          -> 对应的stringValue
 NSNull, @"<Null>", @"(null)" ...  -> nil
 NSData/Array/Dictionary 需要使用toJson.stringValue来转换为字符串。
 */
+ (NSString *(^)(NSString *obj))safe;

@end

@interface NSNumber (AXSafeAdd)

/**
 安全的NSNumber，如果传入obj不是NSNumber，则返回def
 */
+ (NSNumber *(^)(NSNumber *obj))safe;

@end

@interface NSData (AXSafeAdd)

/**
 安全的NSData，如果传入obj不是NSData，则返回def
 */
+ (NSData *(^)(NSData *obj))safe;

@end

@interface NSArray (AXSafeAdd)

/**
 安全的NSArray，如果传入obj是NSArray就返回obj，如果不是NSArray，则判断下一参数，直到没有参数，返回nil。
 */
+ (NSArray *(^)(NSArray *obj))safe;

@end

@interface NSDictionary (AXSafeAdd)

/**
 安全的data，如果传入obj不是data，则返回def
 */
+ (NSDictionary *(^)(NSDictionary *obj))safe;


@end

NS_ASSUME_NONNULL_END
