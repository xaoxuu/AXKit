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
+ (NSString *(^)(id obj, NSString * __nullable def))safeString;

@end

@interface NSNumber (AXSafeAdd)

/**
 安全的NSNumber，如果传入obj不是NSNumber，则返回def
 */
+ (NSNumber *(^)(id obj, NSNumber * __nullable def))safeNumber;

@end

@interface NSData (AXSafeAdd)

/**
 安全的NSData，如果传入obj不是NSData，则返回def
 */
+ (NSData *(^)(id obj, NSData * __nullable def))safeData;

@end

@interface NSArray (AXSafeAdd)

/**
 安全的data，如果传入obj不是data，则返回def
 */
+ (NSArray *(^)(id obj, NSArray * __nullable def))safeArray;

@end

@interface NSDictionary (AXSafeAdd)

/**
 安全的data，如果传入obj不是data，则返回def
 */
+ (NSDictionary *(^)(id obj, NSDictionary * __nullable def))safeDictionary;

@end

NS_ASSUME_NONNULL_END
