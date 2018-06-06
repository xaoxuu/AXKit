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

+ (nullable id)ax_readObjectForKey:(NSString *)key{
    return [DefaultUser() objectForKey:key];
}

+ (void)ax_readObjectForKey:(NSString *)key completion:(void (^)(id object))completion failure:(void (^)(NSError *error))failure{
    readObjForKey(key, @"object", completion, failure);
}

+ (BOOL)ax_readBoolForKey:(NSString *)key{
    return [DefaultUser() boolForKey:key];
}

+ (NSInteger)ax_readIntegerForKey:(NSString *)key{
    return [DefaultUser() integerForKey:key];
}

+ (float)ax_readFloatForKey:(NSString *)key{
    return [DefaultUser() floatForKey:key];
}

+ (double)ax_readDoubleForKey:(NSString *)key{
    return [DefaultUser() doubleForKey:key];
}

+ (CGFloat)ax_readCGFloatForKey:(NSString *)key{
    return [DefaultUser() doubleForKey:key];
}

+ (nullable NSData *)ax_readDataForKey:(NSString *)key{
    return [DefaultUser() dataForKey:key];
}

+ (void)ax_readDataForKey:(NSString *)key completion:(void (^)(NSData *data))completion failure:(void (^)(NSError *error))failure{
    readObjForKey(key, @"data", completion, failure);
}

+ (nullable NSString *)ax_readStringForKey:(NSString *)key{
    return [DefaultUser() stringForKey:key];
}

+ (void)ax_readStringForKey:(NSString *)key completion:(void (^)(NSString *string))completion failure:(void (^)(NSError *error))failure{
    readObjForKey(key, @"string", completion, failure);
}

+ (nullable NSArray *)ax_readArrayForKey:(NSString *)key{
    return [DefaultUser() arrayForKey:key];
}

+ (void)ax_readArrayForKey:(NSString *)key completion:(void (^)(NSArray *array))completion failure:(void (^)(NSError *error))failure{
    readObjForKey(key, @"array", completion, failure);
}

+ (nullable NSDictionary<NSString *, id> *)ax_readDictionaryForKey:(NSString *)key{
    return [DefaultUser() dictionaryForKey:key];
}

+ (void)ax_readDictionaryForKey:(NSString *)key completion:(void (^)(NSDictionary *dictionary))completion failure:(void (^)(NSError *error))failure{
    readObjForKey(key, @"dictionary", completion, failure);
}

+ (NSDictionary<NSString *, id> *)ax_readDictionaryWithValuesForKeys:(NSArray<NSString *> *)keys{
    return [DefaultUser() dictionaryWithValuesForKeys:keys];
}

+ (nullable NSURL *)ax_readURLForKey:(NSString *)key{
    return [DefaultUser() URLForKey:key];
}


+ (void)ax_readURLForKey:(NSString *)key completion:(void (^)(NSURL *url))completion failure:(void (^)(NSError *error))failure{
    readObjForKey(key, @"URL", completion, failure);
}

+ (UIImage *)ax_readImageForKey:(NSString *)key{
    NSData *data = [self ax_readDataForKey:key];
    return [UIImage imageWithData:data];
}

+ (void)ax_readImageForKey:(NSString *)key completion:(void (^)(UIImage * _Nonnull))completion failure:(void (^)(NSError * _Nonnull))failure{
    readObjForKey(key, @"image", ^(id object) {
        NSData *data = object;
        if (completion) {
            completion([UIImage imageWithData:data]);
        }
    }, failure);
}


#pragma mark - write

+ (void)ax_caches:(void (^)(NSUserDefaults *defaultUser))action{
    action(DefaultUser());
    [DefaultUser() synchronize];
}


+ (void)ax_setObject:(nullable id)obj forKey:(NSString *)key{
    [DefaultUser() setObject:obj forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setValue:(nullable id)value forKey:(NSString *)key{
    [DefaultUser() setValue:value forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setBool:(BOOL)x forKey:(NSString *)key{
    [DefaultUser() setBool:x forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setInteger:(NSInteger)x forKey:(NSString *)key{
    [DefaultUser() setInteger:x forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setFloat:(float)x forKey:(NSString *)key{
    [DefaultUser() setFloat:x forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setDouble:(double)x forKey:(NSString *)key{
    [DefaultUser() setDouble:x forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setCGFloat:(CGFloat)x forKey:(NSString *)key{
    [DefaultUser() setDouble:x forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setData:(nullable NSData *)data forKey:(NSString *)key{
    [DefaultUser() setObject:data forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setString:(nullable NSString *)string forKey:(NSString *)key{
    [DefaultUser() setObject:string forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setArray:(nullable NSArray *)arr forKey:(NSString *)key{
    [DefaultUser() ax_setArray:arr forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setDictionary:(nullable NSDictionary *)dict forKey:(NSString *)key{
    [DefaultUser() ax_setDictionary:dict forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setURL:(nullable NSURL *)url forKey:(NSString *)key{
    [DefaultUser() setObject:url forKey:key];
    [DefaultUser() synchronize];
}

+ (void)ax_setImage:(nullable UIImage *)image forKey:(NSString *)key{
    NSData *data = UIImagePNGRepresentation(image);
    [DefaultUser() setObject:data forKey:key];
}

- (void)ax_caches:(void (^)(NSUserDefaults *user))action{
    action(self);
    [self synchronize];
}

- (void)ax_setData:(nullable NSData *)data forKey:(NSString *)key{
    [self setObject:data forKey:key];
}

- (void)ax_setString:(nullable NSString *)string forKey:(NSString *)key{
    [self setObject:string forKey:key];
}

- (void)ax_setArray:(nullable NSArray *)arr forKey:(NSString *)key{
    [self setObject:arr forKey:key];
}

- (void)ax_setDictionary:(nullable NSDictionary *)dict forKey:(NSString *)key{
    [self setObject:dict forKey:key];
}
- (void)ax_setURL:(nullable NSURL *)url forKey:(NSString *)key{
    [self setObject:url forKey:key];
}

#pragma mark - remove

+ (void)ax_removeObjectForKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser removeObjectForKey:key];
    }];
}

+ (void)ax_removeDefaultPersistentDomain{
    [DefaultUser() removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

#pragma mark - private 



@end


