//
//  NSUserDefaults+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSUserDefaults+AXAdd.h"
#import "NSError+AXAdd.h"
#import "NSLog+AXAdd.h"
#import "_AXKitError.h"
#import "NSObject+AXAdd.h"
static inline NSUserDefaults *DefaultUser(){
    return [NSUserDefaults standardUserDefaults];
}
@implementation NSError (AXUserDefaults)

+ (instancetype)axkit_errorWithReason:(NSString *(^)(void))reason{
    return [self axkit_errorWithCode:AXKitErrorCodeObjectForKeyNotFound reason:^NSString * _Nonnull{
        return reason?reason():nil;
    }];
}

@end

@implementation NSUserDefaults (AXAdd)

#pragma mark - read

+ (nullable AXResult *(^)(NSString *key))objectResult{
    return ^id (NSString *key){
        return [AXResult resultWithIdResult:^id _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return [DefaultUser() objectForKey:key];
        }];
    };
}
- (nullable AXResult *(^)(NSString *key))objectResult{
    return ^id (NSString *key){
        return [AXResult resultWithIdResult:^id _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return [self objectForKey:key];
        }];
    };
}

+ (nullable id (^)(NSString *key))object{
    return ^id (NSString *key){
        return [DefaultUser() objectForKey:key];
    };
}
- (nullable id (^)(NSString *key))object{
    return ^id (NSString *key){
        return [self objectForKey:key];
    };
}

+ (nullable NSString *(^)(NSString *key))string{
    return ^id (NSString *key){
        return [DefaultUser() objectForKey:key];
    };
}
- (nullable NSString *(^)(NSString *key))string{
    return ^id (NSString *key){
        return [self objectForKey:key];
    };
}

+ (nullable NSNumber *(^)(NSString *key))number{
    return ^id (NSString *key){
        return autoNumber([DefaultUser() objectForKey:key], nil);
    };
}
- (nullable NSNumber *(^)(NSString *key))number{
    return ^id (NSString *key){
        return autoNumber([self objectForKey:key], nil);
    };
}

+ (nullable NSArray *(^)(NSString *key))array{
    return ^id (NSString *key){
        return autoArray([DefaultUser() objectForKey:key], nil);
    };
}
- (nullable NSArray *(^)(NSString *key))array{
    return ^id (NSString *key){
        return autoArray([self objectForKey:key], nil);
    };
}

+ (nullable NSDictionary *(^)(NSString *key))dictionary{
    return ^id (NSString *key){
        return autoDictionary([DefaultUser() objectForKey:key], nil);
    };
}
- (nullable NSDictionary *(^)(NSString *key))dictionary{
    return ^id (NSString *key){
        return autoDictionary([self objectForKey:key], nil);
    };
}

+ (nullable NSData *(^)(NSString *key))data{
    return ^id (NSString *key){
        return safeData([DefaultUser() objectForKey:key], nil);
    };
}
- (nullable NSData *(^)(NSString *key))data{
    return ^id (NSString *key){
        return safeData([self objectForKey:key], nil);
    };
}

+ (nullable UIImage *(^)(NSString *key))image{
    return ^id (NSString *key){
        return DefaultUser().image(key);
    };
}
- (nullable UIImage *(^)(NSString *key))image{
    return ^id (NSString *key){
        NSData *data = safeData([self objectForKey:key], nil);
        if (data) {
            return [UIImage imageWithData:data];
        } else {
            return nil;
        }
    };
}

+ (nullable NSURL *(^)(NSString *key))URL{
    return ^NSURL *(NSString *key){
        return [DefaultUser() URLForKey:key];
    };
}
- (nullable NSURL *(^)(NSString *key))URL{
    return ^NSURL *(NSString *key){
        return [self URLForKey:key];
    };
}

#pragma mark - write

+ (void (^)(id , NSString * _Nonnull))set{
    return ^(id obj, NSString *key){
        [DefaultUser() setObject:obj forKey:key];
        [DefaultUser() synchronize];
    };
}
- (void (^)(id , NSString * _Nonnull))set{
    return ^(id obj, NSString *key){
        [self setObject:obj forKey:key];
        [self synchronize];
    };
}

+ (void)ax_caches:(void (^)(NSUserDefaults *defaultUser))action{
    action(DefaultUser());
    [DefaultUser() synchronize];
}

- (void)ax_caches:(void (^)(NSUserDefaults *user))action{
    action(self);
    [self synchronize];
}

#pragma mark - remove

+ (void (^)(NSString *key))remove{
    return ^(NSString *key){
        DefaultUser().remove(key);
    };
}
- (void (^)(NSString *key))remove{
    return ^(NSString *key){
        [self removeObjectForKey:key];
        [self synchronize];
    };
}

+ (void (^)(void))removeDefaultPersistentDomain{
    return ^{
        [DefaultUser() removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    };
}
- (void (^)(void))removeDefaultPersistentDomain{
    return ^{
        [self removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    };
}


@end


