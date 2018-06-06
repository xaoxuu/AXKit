//
//  NSDateFormatter+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 2018/6/6.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXMacros.h"

@interface NSDateFormatter (AXAdd)

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
 formatter with timezone
 */
+ (nullable NSDateFormatter *(^)(NSString *dateFormat, NSTimeZone *timeZone))formatterWithTimeZone;


/**
 shared instance
 */
+ (nullable NSDateFormatter *(^)(NSString *dateFormat))sharedFormatter;

/**
 date
 */
- (nullable NSDate *(^)(NSString *dateString))date;

/**
 string
 */
- (nullable NSString *(^)(NSDate *date))stringValue;

@end
