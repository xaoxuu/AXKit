//
//  NSDate+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSDate (AXExtension)


/**
 8位数的整型值(yyyyMMdd)
 */
@property (assign, readonly, nonatomic) NSInteger integerValue;

/**
 8位数的整型值(yyyyMMdd)
 */
@property (assign, readonly, nonatomic) int intValue;

/**
 ISOformat字符串(yyyy-MM-dd'T'HH:mm:ssZ)
 */
@property (strong, readonly, nonatomic) NSString *isoStringValue;


/**
 将8位数的日期值(yyyyMMdd)转换成日期
 
 @param integerValue 8位数的整型值(yyyyMMdd)
 @return 日期
 */
+ (nullable instancetype)ax_dateWithIntegerValue:(NSInteger)integerValue;

/**
 根据日期字符串和格式生成日期

 @param dateString 日期字符串
 @param format 格式
 @return 日期
 */
+ (nullable instancetype)ax_dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 根据日期字符串、格式、时区、locale生成日期

 @param dateString 日期字符串
 @param format 格式
 @param timeZone 时区
 @param locale locale
 @return 日期
 */
+ (nullable instancetype)ax_dateWithString:(NSString *)dateString
                                    format:(NSString *)format
                                  timeZone:(nullable NSTimeZone *)timeZone
                                    locale:(nullable NSLocale *)locale;

/**
 根据ISOformat字符串生成日期

 @param dateString ISOformat字符串
 @return 日期
 */
+ (nullable instancetype)ax_dateWithISOFormatString:(NSString *)dateString;

/**
 根据日期格式生成日期字符串

 @param format 日期格式
 @return 日期字符串
 */
- (nullable NSString *)ax_stringWithFormat:(NSString *)format;

/**
 根据日期格式、时区、locale生成日期字符串
 
 @param format 格式
 @param timeZone 时区
 @param locale locale
 @return 日期字符串
 */
- (nullable NSString *)ax_stringWithFormat:(NSString *)format
                                  timeZone:(nullable NSTimeZone *)timeZone
                                    locale:(nullable NSLocale *)locale;

/**
 生成日期format格式的字符串，传入参数为format
 */
- (nullable NSString *(^)(NSString *))stringValue;


#pragma mark - 日期计算

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
