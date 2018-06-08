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

// MARK: - init

+ (NSDate * _Nonnull (^)(NSString *format, NSString *dateString))initWithFormat{
    return ^NSDate *(NSString *format, NSString *dateString){
        return NSDateFormatter.formatter(format).date(dateString);
    };
}

+ (nullable NSDate *(^)(NSDateFormatter *formatter, NSString *dateString))initWithFormatter{
    return ^NSDate *(NSDateFormatter *formatter, NSString *dateString){
        return formatter.date(dateString);
    };
}


// MARK: - format

/**
 生成日期format格式的字符串，传入参数为format
 */
- (nullable NSString *(^)(NSString *))stringWithFormat{
    return ^(NSString *format){
        return NSDateFormatter.sharedFormatter(format).stringValue(self);
    };
}
- (nullable NSString *(^)(NSDateFormatter *formatter))stringWithFormatter{
    return ^(NSDateFormatter *formatter){
        return formatter.stringValue(self);
    };
}

- (nullable NSString *(^)(NSDateFormatterStyle dateStyle, NSDateFormatterStyle timeStyle))localizedStringWithStyle{
    return ^(NSDateFormatterStyle dateStyle, NSDateFormatterStyle timeStyle){
        return [NSDateFormatter localizedStringFromDate:self dateStyle:dateStyle timeStyle:timeStyle];
    };
}

- (NSString *)yyyyMMdd{
    return self.stringWithFormat(@"yyyyMMdd");
}
- (NSString *)stringWithStandardFormat{
    return self.stringWithFormat(@"yyyy-MM-dd HH:mm:ss");
}


// MARK: - calc

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
