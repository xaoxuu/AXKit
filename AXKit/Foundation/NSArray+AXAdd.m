//
//  NSArray+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 03/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSArray+AXAdd.h"

@implementation NSArray (AXAdd)


- (CGFloat)ax_sum{
    return [[self valueForKeyPath:@"@sum.doubleValue"] doubleValue];
}

- (CGFloat)ax_avg{
    return [[self valueForKeyPath:@"@avg.doubleValue"] doubleValue];
}

- (CGFloat)ax_max{
    return [[self valueForKeyPath:@"@max.doubleValue"] doubleValue];
}

- (CGFloat)ax_min{
    return [[self valueForKeyPath:@"@min.doubleValue"] doubleValue];
}

- (instancetype)distinctUnionOfObjects{
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

- (NSArray *(^)(void))reversed{
    return ^NSArray *{
        return [NSMutableArray arrayWithArray:self].reversed();
    };
}

@end

@interface NSMutableArray<ObjectType> (AXAdd2)

@end
@implementation NSMutableArray (AXAdd)

- (NSMutableArray *(^)(void))reversed{
    return ^NSMutableArray *{
        NSUInteger count = self.count;
        int mid = floor(count / 2.0);
        for (NSUInteger i = 0; i < mid; i++) {
            [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
        }
        return self;
    };
}


- (void (^)(id obj))append{
    return ^(id obj){
        [self addObject:obj];
    };
}
- (void (^)(id obj, NSUInteger index))insertObjectAtIndex{
    return ^(id obj, NSUInteger index){
        [self insertObject:obj atIndex:index];
    };
}

- (void (^)(NSUInteger index))removeObjectAtIndex{
    return ^(NSUInteger index){
        [self removeObjectAtIndex:index];
    };
}
- (void (^)(id obj))removeObject{
    return ^(id obj){
        [self removeObject:obj];
    };
}

@end
