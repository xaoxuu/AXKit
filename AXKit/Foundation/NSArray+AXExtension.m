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
    return [[self valueForKeyPath:@"@sum.floatValue"] floatValue];
}

- (CGFloat)ax_avg{
    return [[self valueForKeyPath:@"@avg.floatValue"] floatValue];
}

- (CGFloat)ax_max{
    return [[self valueForKeyPath:@"@max.floatValue"] floatValue];
}

- (CGFloat)ax_min{
    return [[self valueForKeyPath:@"@min.floatValue"] floatValue];
}


@end
