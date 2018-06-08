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
#import "NSObject+AXJsonAdd.h"


@implementation NSError (AXUserDefaults)

+ (instancetype)axkit_errorWithReason:(NSString *(^)(void))reason{
    return [self axkit_errorWithCode:AXKitErrorCodeObjectForKeyNotFound reason:^NSString * _Nonnull{
        return reason?reason():nil;
    }];
}

@end

@implementation NSUserDefaults (AXAdd)

+ (NSUserDefaults *)standard{
    return NSUserDefaults.standardUserDefaults;
}

#pragma mark - read

+ (nullable AXResult *(^)(NSString *key))objectResult{
    return ^id (NSString *key){
        return [AXResult resultWithIdResult:^id _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return [self.standard objectForKey:key];
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

+ (nullable id (^)(NSString *key))objectForKey{
    return ^id (NSString *key){
        return [self.standard objectForKey:key];
    };
}
- (nullable id (^)(NSString *key))objectForKey{
    return ^id (NSString *key){
        return [self objectForKey:key];
    };
}

+ (nullable NSString *(^)(NSString *key))string{
    return ^id (NSString *key){
        return [self.standard objectForKey:key];
    };
}
- (nullable NSString *(^)(NSString *key))string{
    return ^id (NSString *key){
        return [self objectForKey:key];
    };
}

+ (nullable NSNumber *(^)(NSString *key))number{
    return ^id (NSString *key){
        return NSNumber.autoNumber([self.standard objectForKey:key], nil);
    };
}
- (nullable NSNumber *(^)(NSString *key))number{
    return ^id (NSString *key){
        return NSNumber.autoNumber([self objectForKey:key], nil);
    };
}

+ (nullable NSArray *(^)(NSString *key))array{
    return ^id (NSString *key){
        return NSArray.autoArray([self.standard objectForKey:key], nil);
    };
}
- (nullable NSArray *(^)(NSString *key))array{
    return ^id (NSString *key){
        return NSArray.autoArray([self objectForKey:key], nil);
    };
}

+ (nullable NSDictionary *(^)(NSString *key))dictionary{
    return ^id (NSString *key){
        return NSDictionary.autoDictionary([self.standard objectForKey:key], nil);
    };
}
- (nullable NSDictionary *(^)(NSString *key))dictionary{
    return ^id (NSString *key){
        return NSDictionary.autoDictionary([self objectForKey:key], nil);
    };
}

+ (nullable NSData *(^)(NSString *key))data{
    return ^id (NSString *key){
        return NSData.safeData([self.standard objectForKey:key], nil);
    };
}
- (nullable NSData *(^)(NSString *key))data{
    return ^id (NSString *key){
        return NSData.safeData([self objectForKey:key], nil);
    };
}

+ (nullable UIImage *(^)(NSString *key))image{
    return ^id (NSString *key){
        return self.standard.image(key);
    };
}
- (nullable UIImage *(^)(NSString *key))image{
    return ^id (NSString *key){
        NSData *data = NSData.safeData([self objectForKey:key], nil);
        if (data) {
            return [UIImage imageWithData:data];
        } else {
            return nil;
        }
    };
}

+ (nullable NSURL *(^)(NSString *key))URL{
    return ^NSURL *(NSString *key){
        return [self.standard URLForKey:key];
    };
}
- (nullable NSURL *(^)(NSString *key))URL{
    return ^NSURL *(NSString *key){
        return [self URLForKey:key];
    };
}

#pragma mark - write

+ (void (^)(id , NSString * _Nonnull))setObjectForKey{
    return ^(id obj, NSString *key){
        [self.standard setObject:obj forKey:key];
        [self.standard synchronize];
    };
}
- (void (^)(id , NSString * _Nonnull))setObjectForKey{
    return ^(id obj, NSString *key){
        [self setObject:obj forKey:key];
        [self synchronize];
    };
}

+ (void)ax_caches:(void (^)(NSUserDefaults *defaultUser))action{
    action(self.standard);
    [self.standard synchronize];
}

- (void)ax_caches:(void (^)(NSUserDefaults *user))action{
    action(self);
    [self synchronize];
}

#pragma mark - remove

+ (void (^)(NSString *key))removeObjectForKey{
    return ^(NSString *key){
        self.standard.removeObjectForKey(key);
    };
}
- (void (^)(NSString *key))removeObjectForKey{
    return ^(NSString *key){
        [self removeObjectForKey:key];
        [self synchronize];
    };
}


+ (void (^)(NSString *name))removePersistentDomainForName{
    return ^(NSString *name){
        [self.standard removePersistentDomainForName:name];
    };
}

- (void (^)(NSString *name))removePersistentDomainForName{
    return ^(NSString *name){
        [self removePersistentDomainForName:name];
    };
}

+ (void (^)(void))removeDefaultPersistentDomain{
    return ^{
        [self.standard removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    };
}
- (void (^)(void))removeDefaultPersistentDomain{
    return ^{
        [self removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    };
}


@end


