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

- (double)doubleValueForKey:(NSString *)key;

- (NSInteger)integerValueForKey:(NSString *)key;
- (BOOL)boolValueForKey:(NSString *)key;

@end
NS_ASSUME_NONNULL_END
