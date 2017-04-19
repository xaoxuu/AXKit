//
//  NSUserDefaults+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSUserDefaults+AXWrapper.h"

#define AXDefaultUser [NSUserDefaults standardUserDefaults]

@implementation NSUserDefaults (AXWrapper)

#pragma mark read

+ (BOOL)ax_readUserDefaultBoolWithKey:(NSString *)key{
    return [AXDefaultUser boolForKey:key];
}

+ (nullable id)ax_readUserDefaultValueWithKey:(NSString *)key{
    return [AXDefaultUser objectForKey:key];
}


#pragma mark write

+ (void)ax_caches:(void (^)(NSUserDefaults *defaultUser))action{
    action(AXDefaultUser);
    [AXDefaultUser synchronize];
}


+ (void)ax_cacheObject:(nullable id)obj key:(NSString *)key{
    [AXDefaultUser setObject:obj forKey:key];
    [AXDefaultUser synchronize];
}

+ (void)ax_cacheValue:(nullable id)value key:(NSString *)key{
    [AXDefaultUser setValue:value forKey:key];
    [AXDefaultUser synchronize];
}

+ (void)ax_cacheBool:(BOOL)x key:(NSString *)key{
    [AXDefaultUser setBool:x forKey:key];
    [AXDefaultUser synchronize];
}

+ (void)ax_cacheInteger:(NSInteger)x key:(NSString *)key{
    [AXDefaultUser setInteger:x forKey:key];
    [AXDefaultUser synchronize];
}

+ (void)ax_cacheFloat:(float)x key:(NSString *)key{
    [AXDefaultUser setFloat:x forKey:key];
    [AXDefaultUser synchronize];
}

+ (void)ax_cacheDouble:(double)x key:(NSString *)key{
    [AXDefaultUser setDouble:x forKey:key];
    [AXDefaultUser synchronize];
}


- (void)ax_cacheObject:(nullable id)obj key:(NSString *)key{
    [AXDefaultUser setObject:obj forKey:key];
}

- (void)ax_cacheValue:(nullable id)value key:(NSString *)key{
    [AXDefaultUser setValue:value forKey:key];
}

- (void)ax_cacheBool:(BOOL)x key:(NSString *)key{
    [AXDefaultUser setBool:x forKey:key];
}

- (void)ax_cacheInteger:(NSInteger)x key:(NSString *)key{
    [AXDefaultUser setInteger:x forKey:key];
}

- (void)ax_cacheFloat:(float)x key:(NSString *)key{
    [AXDefaultUser setFloat:x forKey:key];
}

- (void)ax_cacheDouble:(double)x key:(NSString *)key{
    [AXDefaultUser setDouble:x forKey:key];
}



#pragma mark remove

+ (void)ax_removeObjectForKey:(NSString *)key{
    [AXDefaultUser removeObjectForKey:key];
    [AXDefaultUser synchronize];
}

- (void)ax_removeObjectForKey:(NSString *)key{
    [AXDefaultUser removeObjectForKey:key];
}

@end

@implementation NSString (CacheUserDefaults)

- (id)readUserDefaultValue{
    return [NSUserDefaults ax_readUserDefaultValueWithKey:self];
}

- (BOOL)readUserDefaultBool{
    return [NSUserDefaults ax_readUserDefaultBoolWithKey:self];
}


- (NSString *(^)(id))cacheUserDefaultValue{
    return ^(id x){
        [NSUserDefaults ax_cacheValue:x key:self];
        return self;
    };
}

- (NSString *(^)(BOOL))cacheUserDefaultBool{
    return ^(BOOL x){
        [NSUserDefaults ax_cacheBool:x key:self];
        return self;
    };
}



@end


