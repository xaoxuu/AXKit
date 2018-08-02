//
//  NSDictionary+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSDictionary+AXAdd.h"
#import "NSObject+AXJsonAdd.h"


static inline NSDictionary *dictionaryValueForKey(NSDictionary *dict, NSString *key){
    return NSDictionary.autoDictionary(dict[key], nil);
}
static inline NSArray *arrayValueForKey(NSDictionary *dict, NSString *key){
    return NSArray.autoArray(dict[key], nil);
}

static inline NSString *stringValueForKey(NSDictionary *dict, NSString *key){
    if (key.length) {
        return NSString.autoString(dict[key], nil);
    }
    return nil;
}
static inline NSNumber *numberValueForKey(NSDictionary *dict, NSString *key){
    if (key.length) {
        return NSNumber.autoNumber(dict[key], nil);
    }
    return nil;
}


@implementation NSDictionary (AXAdd)

+ (nullable instancetype)dictionaryWithJsonString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    } else {
        return nil;
    }
}


- (NSDictionary *)dictionaryValueForKey:(NSString *)key{
    return dictionaryValueForKey(self, key);
}

- (NSArray *)arrayValueForKey:(NSString *)key{
    return arrayValueForKey(self, key);
}

- (NSString *)stringValueForKey:(NSString *)key{
    return stringValueForKey(self, key);
}

- (NSNumber *)numberValueForKey:(NSString *)key{
    return numberValueForKey(self, key);
}

@end
