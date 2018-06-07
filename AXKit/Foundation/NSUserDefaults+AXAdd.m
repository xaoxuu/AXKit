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

static inline void readObjForKey(NSString *key, NSString *desc, void (^completion)(id object), void (^failure)(NSError *error)){
    id obj = [DefaultUser() objectForKey:key];
    if (obj) {
        if (completion) {
            completion(obj);
        }
    } else {
        NSError *error = [NSError axkit_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The %@ for key: \'%@\' not found.\n", desc, key];
        }];
        if (failure && error) {
            failure(error);
        }
    }
}

@implementation NSUserDefaults (AXAdd)


#pragma mark - read

+ (nullable AXResult *(^)(NSString *key))objectResult{
    return ^id (NSString *key){
        return [AXResult resultWithIdResult:^id _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return [DefaultUser() objectForKey:key];
        }];
    };
}

+ (nullable id (^)(NSString *key))object{
    return ^id (NSString *key){
        return [DefaultUser() objectForKey:key];
    };
}
+ (nullable NSString *(^)(NSString *key))string{
    return ^id (NSString *key){
        return [DefaultUser() objectForKey:key];
    };
}
+ (nullable NSNumber *(^)(NSString *key))number{
    return ^id (NSString *key){
        return autoNumber([DefaultUser() objectForKey:key], nil);
    };
}
+ (nullable NSArray *(^)(NSString *key))array{
    return ^id (NSString *key){
        return safeArray([DefaultUser() objectForKey:key], nil);
    };
}
+ (nullable NSDictionary *(^)(NSString *key))dictionary{
    return ^id (NSString *key){
        return safeDictionary([DefaultUser() objectForKey:key], nil);
    };
}
+ (nullable NSData *(^)(NSString *key))data{
    return ^id (NSString *key){
        return safeData([DefaultUser() objectForKey:key], nil);
    };
}
+ (nullable UIImage *(^)(NSString *key))image{
    return ^id (NSString *key){
        NSData *data = safeData([DefaultUser() objectForKey:key], nil);
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


#pragma mark - write

+ (void (^)(id , NSString * _Nonnull))set{
    return ^(id obj, NSString *key){
        [DefaultUser() setObject:obj forKey:key];
        [DefaultUser() synchronize];
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
        [DefaultUser() removeObjectForKey:key];
        [DefaultUser() synchronize];
    };
}
+ (void)ax_removeDefaultPersistentDomain{
    [DefaultUser() removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}
+ (void (^)(void))removeDefaultPersistentDomain{
    return ^{
        [DefaultUser() removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    };
}
#pragma mark - private 



@end


