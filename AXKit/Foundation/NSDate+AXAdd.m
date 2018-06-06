//
//  NSDate+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSDate+AXAdd.h"
#import "NSDateFormatter+AXAdd.h"
static NSString *yyyyMMdd = @"yyyyMMdd";
static NSString *ISOFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";

static inline NSCalendar *calendar(){
    return [NSCalendar currentCalendar];
}


@implementation NSDate (AXAdd)

/**
 8位数的整型值(yyyyMMdd)
 */
- (NSInteger)integerValue{
    return NSDateFormatter.sharedFormatter(yyyyMMdd).stringValue(self).integerValue;
}

/**
 8位数的整型值(yyyyMMdd)
 */
- (int)intValue{
    return NSDateFormatter.sharedFormatter(yyyyMMdd).stringValue(self).intValue;
}

/**
 ISOformat字符串(yyyy-MM-dd'T'HH:mm:ssZ)
 */
- (NSString *)isoStringValue{
    return NSDateFormatter.sharedFormatter(ISOFormat).stringValue(self);
}

/**
 将8位数的日期值(yyyyMMdd)转换成日期
 
 @param integerValue 8位数的整型值(yyyyMMdd)
 @return 日期
 */
+ (nullable instancetype)ax_dateWithIntegerValue:(NSInteger)integerValue{
    NSString *dateString = [NSString stringWithFormat:@"%08d", (int)integerValue];
    return NSDateFormatter.formatter(yyyyMMdd).date(dateString);
}

+ (NSDate * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))dateWithStringAndFormat{
    return ^NSDate *(NSString *dateString, NSString *format){
        return NSDateFormatter.formatter(format).date(dateString);
    };
}

+ (NSDate * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))dateWithUTCStringAndFormat{
    return ^NSDate *(NSString *dateString, NSString *format){
        return NSDateFormatter.utcFormatter(format).date(dateString);
    };
}

/**
 根据日期字符串和格式生成日期
 
 @param dateString 日期字符串
 @param format 格式
 @return 日期
 */
+ (nullable instancetype)ax_dateWithString:(NSString *)dateString format:(NSString *)format{
    return NSDateFormatter.formatter(format).date(dateString);
}

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
                                    locale:(nullable NSLocale *)locale{
    NSDateFormatter *fm = NSDateFormatter.formatterWithTimeZone(format, timeZone);
    fm.locale = locale;
    return fm.date(dateString);
}

/**
 根据ISOformat字符串生成日期
 
 @param dateString ISOformat字符串
 @return 日期
 */
+ (nullable instancetype)ax_dateWithISOFormatString:(NSString *)dateString{
    return NSDateFormatter.formatter(ISOFormat).date(dateString);
}

/**
 根据日期格式生成日期字符串
 
 @param format 日期格式
 @return 日期字符串
 */
- (nullable NSString *)ax_stringWithFormat:(NSString *)format{
    return NSDateFormatter.sharedFormatter(format).stringValue(self);
}

/**
 根据日期格式、时区、locale生成日期字符串
 
 @param format 格式
 @param timeZone 时区
 @param locale locale
 @return 日期字符串
 */
- (nullable NSString *)ax_stringWithFormat:(NSString *)format
                                  timeZone:(nullable NSTimeZone *)timeZone
                                    locale:(nullable NSLocale *)locale{
    NSDateFormatter *fm = NSDateFormatter.formatterWithTimeZone(format, timeZone);
    fm.locale = locale;
    return fm.stringValue(self);
}

/**
 生成日期format格式的字符串，传入参数为format
 */
- (nullable NSString *(^)(NSString *))stringValue{
    return ^(NSString *format){
        return NSDateFormatter.sharedFormatter(format).stringValue(self);
    };
}


#pragma mark - 日期计算

/**
 增加年
 */
- (nullable NSDate *(^)(NSInteger))addYears{
    return ^(NSInteger x){
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year = x;
        return [calendar() dateByAddingComponents:components toDate:self options:0];
    };
}

/**
 增加月
 */
- (nullable NSDate *(^)(NSInteger))addMonths{
    return ^(NSInteger x){
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.month = x;
        return [calendar() dateByAddingComponents:components toDate:self options:0];
    };
}

/**
 增加周数（一年中的第几周）
 */
- (nullable NSDate *(^)(NSInteger))addWeeks{
    return ^(NSInteger x){
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.weekOfYear = x;
        return [calendar() dateByAddingComponents:components toDate:self options:0];
    };
}

/**
 增加天
 */
- (nullable NSDate *(^)(NSInteger))addDays{
    return ^(NSInteger x){
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = x;
        return [calendar() dateByAddingComponents:components toDate:self options:0];
    };
}

/**
 增加小时
 */
- (nullable NSDate *(^)(NSInteger))addhours{
    return ^(NSInteger x){
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.hour = x;
        return [calendar() dateByAddingComponents:components toDate:self options:0];
    };
}

/**
 增加分钟
 */
- (nullable NSDate *(^)(NSInteger))addMinutes{
    return ^(NSInteger x){
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.minute = x;
        return [calendar() dateByAddingComponents:components toDate:self options:0];
    };
}

/**
 增加秒
 */
- (nullable NSDate *(^)(NSInteger))addSeconds{
    return ^(NSInteger x){
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.second = x;
        return [calendar() dateByAddingComponents:components toDate:self options:0];
    };
}


@end
