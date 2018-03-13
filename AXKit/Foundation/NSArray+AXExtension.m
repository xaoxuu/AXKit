//
//  NSArray+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 03/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSArray+AXExtension.h"

@implementation NSArray (AXExtension)


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

@end
