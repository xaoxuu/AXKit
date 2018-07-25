//
//  NSArray+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 03/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSArray+AXAdd.h"

@implementation NSArray (AXAdd)


- (CGFloat)ax_sumValue{
    return [[self valueForKeyPath:@"@sum.doubleValue"] doubleValue];
}

- (CGFloat)ax_avgValue{
    return [[self valueForKeyPath:@"@avg.doubleValue"] doubleValue];
}

- (CGFloat)ax_maxValue{
    return [[self valueForKeyPath:@"@max.doubleValue"] doubleValue];
}

- (CGFloat)ax_minValue{
    return [[self valueForKeyPath:@"@min.doubleValue"] doubleValue];
}

- (instancetype)ax_distinctUnionOfObjects{
    return [self valueForKeyPath:@"@distinctUnionOfObjects.self"];
}

/**
 根据json字符串创建数组
 
 @param string json字符串
 @return 数组
 */
+ (instancetype)arrayWithJsonString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    } else {
        return nil;
    }
}

- (NSArray *)reversed{
    return [NSMutableArray arrayWithArray:self].reversed;
}

@end

@implementation NSMutableArray (AXAdd)

- (NSMutableArray *)reversed{
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
    return self;
}

@end
