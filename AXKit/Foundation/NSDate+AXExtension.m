//
//  NSDate+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSDate+AXExtension.h"

static NSString *yyyyMMdd = @"yyyyMMdd";
static NSString *ISOFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";

static inline NSDateFormatter *formatter(){
    static NSDateFormatter *fm;
    if (!fm) {
        fm = [[NSDateFormatter alloc] init];
        fm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    return fm;
}

static inline NSDateFormatter *dateFormatter(NSString *format){
    formatter().dateFormat = format;
    return formatter();
}

static inline NSCalendar *calendar(){
    return [NSCalendar currentCalendar];
}

static inline NSDateComponents *components(){
    static NSDateComponents *cm;
    if (!cm) {
        cm = [[NSDateComponents alloc] init];
    }
    return cm;
}


@implementation NSDate (AXExtension)

/**
 8位数的整型值(yyyyMMdd)
 */
- (NSInteger)integerValue{
    return [dateFormatter(yyyyMMdd) stringFromDate:self].integerValue;
}
- (int)intValue{
    return [dateFormatter(yyyyMMdd) stringFromDate:self].intValue;
}
- (NSString *)isoStringValue{
    return [dateFormatter(ISOFormat) stringFromDate:self];
}

/**
 将8位数的日期值(yyyyMMdd)转换成日期
 
 @param integerValue 8位数的整型值(yyyyMMdd)
 @return 日期
 */
+ (nullable instancetype)ax_dateWithIntegerValue:(NSInteger)integerValue{
    NSString *dateString = [NSString stringWithFormat:@"%08d", (int)integerValue];
    return [dateFormatter(yyyyMMdd) dateFromString:dateString];
}


+ (nullable instancetype)ax_dateWithString:(NSString *)dateString format:(NSString *)format{
    return [dateFormatter(format) dateFromString:dateString];
}


+ (nullable instancetype)ax_dateWithString:(NSString *)dateString
                                    format:(NSString *)format
                                  timeZone:(nullable NSTimeZone *)timeZone
                                    locale:(nullable NSLocale *)locale{
    formatter().dateFormat = format;
    formatter().timeZone = timeZone;
    formatter().locale = locale;
    return [formatter() dateFromString:dateString];
}

+ (nullable instancetype)ax_dateWithISOFormatString:(NSString *)dateString{
    return [dateFormatter(ISOFormat) dateFromString:dateString];
}

- (nullable NSString *)ax_stringWithFormat:(NSString *)format{
    return [dateFormatter(format) stringFromDate:self];
}

- (nullable NSString *)ax_stringWithFormat:(NSString *)format
                                  timeZone:(nullable NSTimeZone *)timeZone
                                    locale:(nullable NSLocale *)locale{
    formatter().dateFormat = format;
    formatter().timeZone = timeZone;
    formatter().locale = locale;
    return [formatter() stringFromDate:self];
}





- (nullable NSString *(^)(NSString *))stringValue{
    return ^(NSString *format){
        return [dateFormatter(format) stringFromDate:self];
    };
}


- (nullable NSDate *(^)(NSInteger))addYears{
    return ^(NSInteger x){
        components().year = x;
        return [calendar() dateByAddingComponents:components() toDate:self options:0];
    };
}
- (nullable NSDate *(^)(NSInteger))addMonths{
    return ^(NSInteger x){
        components().month = x;
        return [calendar() dateByAddingComponents:components() toDate:self options:0];
    };
}
- (nullable NSDate *(^)(NSInteger))addWeeks{
    return ^(NSInteger x){
        components().weekOfYear = x;
        return [calendar() dateByAddingComponents:components() toDate:self options:0];
    };
}
- (nullable NSDate *(^)(NSInteger))addDays{
    return ^(NSInteger x){
        components().day = x;
        return [calendar() dateByAddingComponents:components() toDate:self options:0];
    };
}
- (nullable NSDate *(^)(NSInteger))addhours{
    return ^(NSInteger x){
        components().hour = x;
        return [calendar() dateByAddingComponents:components() toDate:self options:0];
    };
}
- (nullable NSDate *(^)(NSInteger))addMinutes{
    return ^(NSInteger x){
        components().minute = x;
        return [calendar() dateByAddingComponents:components() toDate:self options:0];
    };
}
- (nullable NSDate *(^)(NSInteger))addSeconds{
    return ^(NSInteger x){
        components().second = x;
        return [calendar() dateByAddingComponents:components() toDate:self options:0];
    };
}


@end
