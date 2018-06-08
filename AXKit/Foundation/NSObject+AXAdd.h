//
//  NSObject+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 13/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXResult.h"


/**
 安全的data，如果传入obj不是data，则返回def
 
 @param obj 传入对象
 @param def 默认值
 @return data或默认值
 */
FOUNDATION_EXTERN NSData *safeData(id obj, NSData *def);

/**
 安全的字典，如果传入obj不是字典，则返回def

 @param obj 传入对象
 @param def 默认值
 @return 字典或默认值
 */
FOUNDATION_EXTERN NSDictionary *safeDictionary(id obj, NSDictionary *def);

/**
 自动转换的字典，如果传入值不是字典，但是能够转换成字典，返回转换后的字典

 @param obj 传入对象
 @param def 默认值
 @return 字典或默认值
 */
FOUNDATION_EXTERN NSDictionary *autoDictionary(id obj, NSDictionary *def);

/**
 安全的数组，如果传入obj不是数组，则返回def

 @param obj 传入对象
 @param def 默认值
 @return 数组或默认值
 */
FOUNDATION_EXTERN NSArray *safeArray(id obj, NSArray *def);
/**
 自动转换的数组，如果传入obj不是数组，但是能够转换成数组，则返回转换后的数组
 
 @param obj 传入对象
 @param def 默认值
 @return 数组或默认值
 */
FOUNDATION_EXTERN NSArray *autoArray(id obj, NSArray *def);

/**
 安全的字符串，如果传入obj不是字符串，则返回def
 
 @param obj 传入对象
 @param def 默认值
 @return 字符串或默认值
 */
FOUNDATION_EXTERN NSString *safeString(id obj, NSString *def);
/**
 安全的字符串，如果传入obj不是字符串，但是能够转换成字符串，则返回转换后的字符串
 
 @param obj 传入对象
 @param def 默认值
 @return 字符串或默认值
 */
FOUNDATION_EXTERN NSString *autoString(id obj, NSString *def);

/**
 安全的数字，如果传入obj不是数字，则返回def
 
 @param obj 传入对象
 @param def 默认值
 @return 数字或默认值
 */
FOUNDATION_EXTERN NSNumber *safeNumber(id obj, NSNumber *def);
/**
 安全的数字，如果传入obj不是数字，但是能够转换成数字，则返回转换后的数字
 
 @param obj 传入对象
 @param def 默认值
 @return 数字或默认值
 */
FOUNDATION_EXTERN NSNumber *autoNumber(id obj, NSNumber *def);

@interface NSObject (AXAdd)


/**
 获取所有子类

 @return 所有子类
 */
+ (NSArray *)ax_allSubclasses;

- (BOOL (^)(SEL aSelector))respondsToSelector;

@end

@interface NSString (AXJsonExt)

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

@interface NSData (AXJsonExt)
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

@interface NSArray (AXJsonExt)
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

@interface NSDictionary (AXJsonExt)
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
