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

@interface NSString (AXJsonAdd)

/**
 如果传入obj不是NSString，但是能够转换成NSString，则返回转换后的NSString
 */
+ (NSString *(^)(id obj, NSString * __nullable def))autoString;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(void))toJson;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(NSJSONReadingOptions opt))toJsonWithOptions;

@end



@interface NSData (AXJsonAdd)

/**
 如果传入obj不是NSData，但是能够转换成NSData，则返回转换后的NSData
 */
+ (NSData *(^)(id obj, NSData * __nullable def))autoData;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(void))toJson;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(NSJSONReadingOptions opt))toJsonWithOptions;

@end

@interface NSArray (AXJsonAdd)

/**
 如果传入obj不是NSArray，但是能够转换成NSArray，则返回转换后的NSArray
 */
+ (NSArray *(^)(id obj, NSArray * __nullable def))autoArray;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(void))toJson;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(NSJSONWritingOptions opt))toJsonWithOptions;


@end

@interface NSDictionary (AXJsonAdd)

/**
 如果传入obj不是NSDictionary，但是能够转换成NSDictionary，则返回转换后的NSDictionary
 */
+ (NSDictionary *(^)(id obj, NSDictionary * __nullable def))autoDictionary;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(void))toJson;

/**
 转换成json
 
 @return 结果
 */
- (AXResult *(^)(NSJSONWritingOptions opt))toJsonWithOptions;

@end

NS_ASSUME_NONNULL_END
