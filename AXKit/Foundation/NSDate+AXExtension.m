//
//  NSDate+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSDate+AXExtension.h"

static NSString *yyyyMMdd = @"yyyyMMdd";
static NSDateFormatter *formatter;

static inline NSDateFormatter *dateFormatter(NSString *format){
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    formatter.dateFormat = format;
    return formatter;
}


@implementation NSDate (AXExtension)



/**
 8位数的整型值(yyyyMMdd)
 
 @return 8位数的整型值(yyyyMMdd)
 */
- (NSInteger)dateInteger{
    return [dateFormatter(yyyyMMdd) stringFromDate:self].integerValue;
}


/**
 将8位数的日期值(yyyyMMdd)转换成日期
 
 @param dateInteger 8位数的整型值(yyyyMMdd)
 @return 日期
 */
+ (nullable NSDate *)dateWithDateInteger:(NSInteger)dateInteger{
    NSString *dateString = [NSString stringWithFormat:@"%08d", dateInteger];
    return [dateFormatter(yyyyMMdd) dateFromString:dateString];
}




@end
