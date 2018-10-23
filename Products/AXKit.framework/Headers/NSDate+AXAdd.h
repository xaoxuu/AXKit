//
//  NSDate+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSDate (AXAdd)

// MARK: - init

/**
 根据日期格式和字符串生成日期
 */
+ (nullable NSDate *(^)(NSString *format, NSString *dateString))initWithFormat;

/**
 根据NSDateFormatter和字符串生成日期
 */
+ (nullable NSDate *(^)(NSDateFormatter *formatter, NSString *dateString))initWithFormatter;

// MARK: - format

/**
 生成日期format格式的字符串，传入参数为format
 */
- (nullable NSString *(^)(NSString *format))stringWithFormat;

/**
 生成日期format格式的字符串，传入参数为NSDateFormatter
 */
- (nullable NSString *(^)(NSDateFormatter *formatter))stringWithFormatter;

/**
 生成日期格式化字符串
 */
- (nullable NSString *(^)(NSDateFormatterStyle dateStyle, NSDateFormatterStyle timeStyle))localizedStringWithStyle;

/**
 生成"yyyyMMdd"格式的字符串

 @return "yyyyMMdd"格式的字符串
 */
- (NSString *)yyyyMMdd;

/**
 生成"yyyy-MM-dd HH:mm:ss"格式的字符串
 
 @return "yyyy-MM-dd HH:mm:ss"格式的字符串
 */
- (NSString *)stringWithStandardFormat;

// MARK: - calc

/**
 增加年
 */
- (nullable NSDate *(^)(NSInteger))addYears;

/**
 增加月
 */
- (nullable NSDate *(^)(NSInteger))addMonths;

/**
 增加周数（一年中的第几周）
 */
- (nullable NSDate *(^)(NSInteger))addWeeks;

/**
 增加天
 */
- (nullable NSDate *(^)(NSInteger))addDays;

/**
 增加小时
 */
- (nullable NSDate *(^)(NSInteger))addhours;

/**
 增加分钟
 */
- (nullable NSDate *(^)(NSInteger))addMinutes;

/**
 增加秒
 */
- (nullable NSDate *(^)(NSInteger))addSeconds;


@end
NS_ASSUME_NONNULL_END
