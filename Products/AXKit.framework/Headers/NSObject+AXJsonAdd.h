//
//  NSObject+AXJsonAdd.h
//  AXKit
//
//  Created by xaoxuu on 2018/6/8.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXResult.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSData (AXJsonAdd)

/**
 安全的NSData，如果传入obj不是NSData，则返回def
 */
+ (NSData *(^)(id obj, NSData * __nullable def))safeData;


/**
 转换成json
 
 @return 结果
 */
- (AXResult *)jsonValue;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(NSJSONReadingOptions opt))jsonValueWithOptions;

@end

@interface NSString (AXJsonAdd)

/**
 安全的data，如果传入obj不是字符串，则返回def
 */
+ (NSString *(^)(id obj, NSString * __nullable def))safeString;

/**
 安全的字符串，如果传入obj不是字符串，但是能够转换成字符串，则返回转换后的字符串
 */
+ (NSString *(^)(id obj, NSString * __nullable def))autoString;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *)jsonValue;
/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(NSJSONReadingOptions opt))jsonValueWithOptions;

@end

@interface NSNumber (AXJsonAdd)

/**
 安全的NSNumber，如果传入obj不是NSNumber，则返回def
 */
+ (NSNumber *(^)(id obj, NSNumber * __nullable def))safeNumber;

/**
 安全的NSNumber，如果传入obj不是NSNumber，但是能够转换成NSNumber，则返回转换后的NSNumber
 */
+ (NSNumber *(^)(id obj, NSNumber * __nullable def))autoNumber;

@end



@interface NSArray (AXJsonAdd)

/**
 安全的data，如果传入obj不是data，则返回def
 */
+ (NSArray *(^)(id obj, NSArray * __nullable def))safeArray;

/**
 安全的NSArray，如果传入obj不是NSArray，但是能够转换成NSArray，则返回转换后的NSArray
 */
+ (NSArray *(^)(id obj, NSArray * __nullable def))autoArray;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *)jsonValue;
/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(NSJSONWritingOptions opt))jsonValueWithOptions;

@end

@interface NSDictionary (AXJsonAdd)

/**
 安全的data，如果传入obj不是data，则返回def
 */
+ (NSDictionary *(^)(id obj, NSDictionary * __nullable def))safeDictionary;

/**
 安全的NSDictionary，如果传入obj不是NSDictionary，但是能够转换成NSDictionary，则返回转换后的NSDictionary
 */
+ (NSDictionary *(^)(id obj, NSDictionary * __nullable def))autoDictionary;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *)jsonValue;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(NSJSONWritingOptions opt))jsonValueWithOptions;

@end

NS_ASSUME_NONNULL_END
