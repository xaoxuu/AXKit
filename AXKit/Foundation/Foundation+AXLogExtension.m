//
//  Foundation+AXLogExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Foundation+AXLogExtension.h"


// @xaoxuu: log字典
@implementation NSDictionary (AXLogExtension)

//- (void)dsfsdf:(format)

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{\n"];
    // for-in all key-value
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    [str appendString:@"}"];
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end

// @xaoxuu: log数组
@implementation NSArray (AXLogExtension)
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"[\n"];
    // for-in all objects
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    [str appendString:@"]"];
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end
