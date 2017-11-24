//
//  NSDate+AXExtension.h
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
 
 @return 8位数的整型值(yyyyMMdd)
 */
- (NSInteger)dateInteger;


/**
 将8位数的日期值(yyyyMMdd)转换成日期
 
 @param dateInteger 8位数的整型值(yyyyMMdd)
 @return 日期
 */
+ (nullable NSDate *)dateWithDateInteger:(NSInteger)dateInteger;



@end
NS_ASSUME_NONNULL_END
