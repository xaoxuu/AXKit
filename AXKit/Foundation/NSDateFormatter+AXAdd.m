//
//  NSDateFormatter+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 2018/6/6.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "NSDateFormatter+AXAdd.h"

NSString *kDateFormat_ISO = @"yyyy-MM-dd'T'HH:mm:ssZ";
NSString *kDateFormat_Standard = @"yyyy-MM-dd HH:mm:ss";
NSString *kDateFormat_yyyyMMdd = @"yyyyMMdd";

@implementation NSDateFormatter (AXAdd)

// MARK: - init

+ (nullable NSDateFormatter *(^)(NSString *dateFormat))formatter{
    return ^NSDateFormatter *(NSString *dateFormat){
        return self.localFormatter(dateFormat);
    };
}

+ (nullable NSDateFormatter *(^)(NSString *dateFormat))localFormatter{
    return ^NSDateFormatter *(NSString *dateFormat){
        return self.formatter(dateFormat).setTimeZone(NSTimeZone.localTimeZone);
    };
}

+ (nullable NSDateFormatter *(^)(NSString *dateFormat))utcFormatter{
    return ^NSDateFormatter *(NSString *dateFormat){
        return self.formatter(dateFormat).setTimeZone([NSTimeZone timeZoneForSecondsFromGMT:0]);
    };
}

+ (nullable NSDateFormatter *(^)(NSString *__nullable dateFormat))sharedFormatter{
    return ^NSDateFormatter *(NSString *__nullable dateFormat){
        static NSDateFormatter *dateFormatter;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
        }
        if (dateFormat.length) {
            dateFormatter.dateFormat = dateFormat;
        }
        return dateFormatter;
    };
}

// MARK: - set

- (NSDateFormatter *(^)(NSLocale *locale))setLocale{
    return ^NSDateFormatter *(NSLocale *locale){
        self.locale = locale;
        return self;
    };
}
- (NSDateFormatter *(^)(NSTimeZone *timeZone))setTimeZone{
    return ^NSDateFormatter *(NSTimeZone *timeZone){
        self.timeZone = timeZone;
        return self;
    };
}

// MARK: - output

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
