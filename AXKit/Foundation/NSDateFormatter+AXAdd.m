//
//  NSDateFormatter+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 2018/6/6.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "NSDateFormatter+AXAdd.h"

@implementation NSDateFormatter (AXAdd)

+ (nullable NSDateFormatter *(^)(NSString *dateFormat))formatter{
    return ^NSDateFormatter *(NSString *dateFormat){
        return self.localFormatter(dateFormat);
    };
}

+ (nullable NSDateFormatter *(^)(NSString *dateFormat))utcFormatter{
    return ^NSDateFormatter *(NSString *dateFormat){
        return self.formatterWithTimeZone(dateFormat, [NSTimeZone timeZoneForSecondsFromGMT:0]);
    };
}
+ (nullable NSDateFormatter *(^)(NSString *dateFormat))localFormatter{
    return ^NSDateFormatter *(NSString *dateFormat){
        return self.formatterWithTimeZone(dateFormat, [NSTimeZone localTimeZone]);
    };
}
+ (nullable NSDateFormatter *(^)(NSString *dateFormat, NSTimeZone *timeZone))formatterWithTimeZone{
    return ^NSDateFormatter *(NSString *dateFormat, NSTimeZone *timeZone){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = timeZone;
        dateFormatter.dateFormat = dateFormat;
        return dateFormatter;
    };
}


+ (nullable NSDateFormatter *(^)(NSString *dateFormat))sharedFormatter{
    return ^NSDateFormatter *(NSString *dateFormat){
        static NSDateFormatter *dateFormatter;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
        }
        dateFormatter.dateFormat = dateFormat;
        return dateFormatter;
    };
}
- (NSDate *(^)(NSString *))date{
    return ^NSDate *(NSString *dateString){
        return [self dateFromString:dateString];
    };
}
- (NSString *(^)(NSDate *))stringValue{
    return ^NSString *(NSDate *date){
        return [self stringFromDate:date];
    };
}
@end
