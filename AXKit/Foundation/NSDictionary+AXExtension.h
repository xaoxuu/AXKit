//
//  NSDictionary+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSDictionary (AXExtension)


- (NSDictionary *)dictionaryValueForKey:(NSString *)key;

- (NSArray *)arrayValueForKey:(NSString *)key;

- (NSString *)stringValueForKey:(NSString *)key;

- (NSNumber *)numberValueForKey:(NSString *)key;

/**
 根据json字符串创建字典

 @param string json字符串
 @return 字典
 */
+ (instancetype)dictionaryWithJsonString:(NSString *)string;

@end
NS_ASSUME_NONNULL_END
