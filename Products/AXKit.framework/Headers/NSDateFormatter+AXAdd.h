//
//  NSDateFormatter+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 2018/6/6.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXMacros.h"

/** "yyyy-MM-dd'T'HH:mm:ssZ" */
FOUNDATION_EXTERN NSString *kDateFormat_ISO;
/** "yyyy-MM-dd HH:mm:ss" */
FOUNDATION_EXTERN NSString *kDateFormat_Standard;
/** "yyyyMMdd" */
FOUNDATION_EXTERN NSString *kDateFormat_yyyyMMdd;


@interface NSDateFormatter (AXAdd)

// MARK: - init

/**
 local formatter
 */
+ (nullable NSDateFormatter *(^)(NSString *dateFormat))formatter;
/**
 local formatter
 */
+ (nullable NSDateFormatter *(^)(NSString *dateFormat))localFormatter;
/**
 UTC formatter
 */
+ (nullable NSDateFormatter *(^)(NSString *dateFormat))utcFormatter;

/**
 shared instance
 */
+ (nullable NSDateFormatter *(^)(NSString *__nullable dateFormat))sharedFormatter;

// MARK: - set

/**
 set locale
 */
- (NSDateFormatter *(^)(NSLocale *locale))setLocale;

/**
 set time zone
 */
- (NSDateFormatter *(^)(NSTimeZone *timeZone))setTimeZone;

// MARK: - output

/**
 date from string
 */
- (nullable NSDate *(^)(NSString *dateString))date;

/**
 string from date
 */
- (nullable NSString *(^)(NSDate *date))stringValue;

@end
