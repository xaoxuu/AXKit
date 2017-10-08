//
//  NSUserDefaults+AXWrapper.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSUserDefaults+AXWrapper.h"
#import "NSError+AXExtension.h"
#import "Foundation+AXLogExtension.h"
#import "_AXKitHelpServices.h"

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

@implementation NSUserDefaults (AXWrapper)


#pragma mark - read

+ (nullable id)ax_readObjectForKey:(NSString *)key{
    return [DefaultUser() objectForKey:key];
}

+ (void)ax_readObjectForKey:(NSString *)key completion:(void (^)(id object))completion failure:(void (^)(NSError *error))failure{
    id obj = [self ax_readObjectForKey:key];
    if (obj) {
        if (completion) {
            completion(obj);
        }
    } else {
        NSError *error = [NSError axkit_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The object for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
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
    NSData *data = [self ax_readDataForKey:key];
    if (data) {
        if (completion) {
            completion(data);
        }
    } else {
        NSError *error = [NSError axkit_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The data for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
}

+ (nullable NSString *)ax_readStringForKey:(NSString *)key{
    return [DefaultUser() stringForKey:key];
}

+ (void)ax_readStringForKey:(NSString *)key completion:(void (^)(NSString *string))completion failure:(void (^)(NSError *error))failure{
    NSString *string = [self ax_readStringForKey:key];
    if (string) {
        if (completion) {
            completion(string);
        }
    } else {
        NSError *error = [NSError axkit_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The string for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
}

+ (nullable NSArray<NSString *> *)ax_readStringArrayForKey:(NSString *)key{
    return [DefaultUser() stringArrayForKey:key];
}

+ (void)ax_readStringArrayForKey:(NSString *)key completion:(void (^)(NSArray<NSString *> *string))completion failure:(void (^)(NSError *error))failure{
    NSArray<NSString *> *stringArray = [self ax_readStringArrayForKey:key];
    if (stringArray) {
        if (completion) {
            completion(stringArray);
        }
    } else {
        NSError *error = [NSError axkit_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The array for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
}

+ (nullable NSArray *)ax_readArrayForKey:(NSString *)key{
    return [DefaultUser() arrayForKey:key];
}

+ (void)ax_readArrayForKey:(NSString *)key completion:(void (^)(NSArray *array))completion failure:(void (^)(NSError *error))failure{
    NSArray *array = [self ax_readArrayForKey:key];
    if (array) {
        if (completion) {
            completion(array);
        }
    } else {
        NSError *error = [NSError axkit_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The array for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
}

+ (nullable NSDictionary<NSString *, id> *)ax_readDictionaryForKey:(NSString *)key{
    return [DefaultUser() dictionaryForKey:key];
}

+ (void)ax_readDictionaryForKey:(NSString *)key completion:(void (^)(NSDictionary *dictionary))completion failure:(void (^)(NSError *error))failure{
    NSDictionary *dictionary = [self ax_readDictionaryForKey:key];
    if (dictionary) {
        if (completion) {
            completion(dictionary);
        }
    } else {
        NSError *error = [NSError axkit_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The dictionary for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
}

+ (NSDictionary<NSString *, id> *)ax_readDictionaryWithValuesForKeys:(NSArray<NSString *> *)keys{
    return [DefaultUser() dictionaryWithValuesForKeys:keys];
}

+ (nullable NSURL *)ax_readURLForKey:(NSString *)key{
    return [DefaultUser() URLForKey:key];
}


+ (void)ax_readURLForKey:(NSString *)key completion:(void (^)(NSURL *url))completion failure:(void (^)(NSError *error))failure{
    NSURL *url = [self ax_readURLForKey:key];
    if (url) {
        if (completion) {
            completion(url);
        }
    } else {
        NSError *error = [NSError axkit_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The url for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
}

+ (UIImage *)ax_readImageForKey:(NSString *)key{
    NSData *data = [self ax_readDataForKey:key];
    return [UIImage imageWithData:data];
}

+ (void)ax_readImageForKey:(NSString *)key completion:(void (^)(UIImage * _Nonnull))completion failure:(void (^)(NSError * _Nonnull))failure{
    NSData *data = [self ax_readDataForKey:key];
    if (data) {
        if (completion) {
            completion([UIImage imageWithData:data]);
        }
    } else {
        NSError *error = [NSError axkit_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The image for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (failure && error) {
            failure(error);
        }
    }
}


#pragma mark - write

+ (void)ax_caches:(void (^)(NSUserDefaults *defaultUser))action{
    action(DefaultUser());
    [DefaultUser() synchronize];
}


+ (void)ax_setObject:(nullable id)obj forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setObject:obj forKey:key];
    }];
}

+ (void)ax_setValue:(nullable id)value forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setValue:value forKey:key];
    }];
}

+ (void)ax_setBool:(BOOL)x forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setBool:x forKey:key];
    }];
}

+ (void)ax_setInteger:(NSInteger)x forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setInteger:x forKey:key];
    }];
}

+ (void)ax_setFloat:(float)x forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setFloat:x forKey:key];
    }];
}

+ (void)ax_setDouble:(double)x forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setDouble:x forKey:key];
    }];
}

+ (void)ax_setCGFloat:(CGFloat)x forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setDouble:x forKey:key];
    }];
}

+ (void)ax_setData:(NSData *)data forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setObject:data forKey:key];
    }];
}

+ (void)ax_setString:(NSString *)string forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setObject:string forKey:key];
    }];
}

+ (void)ax_setStringArray:(NSArray *(^)(NSArray<NSString *> *cachedArray))block forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser ax_setArray:block forKey:key];
    }];
}

+ (void)ax_setArray:(NSArray *(^)(NSArray *cachedArray))block forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser ax_setArray:block forKey:key];
    }];
}

+ (void)ax_setDictionary:(NSDictionary *(^)(NSMutableDictionary <NSString *, id> * dict))block forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser ax_setDictionary:block forKey:key];
    }];
}


+ (void)ax_setURL:(NSURL *)url forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser setObject:url forKey:key];
    }];
}

+ (void)ax_setImage:(UIImage *)image forKey:(NSString *)key{
    [self ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        NSData *data = UIImagePNGRepresentation(image);
        [defaultUser setObject:data forKey:key];
    }];
}

- (void)ax_caches:(void (^)(NSUserDefaults *user))action{
    action(self);
    [self synchronize];
}

- (void)ax_setData:(NSData *)data forKey:(NSString *)key{
    [self setObject:data forKey:key];
}

- (void)ax_setString:(NSString *)string forKey:(NSString *)key{
    [self setObject:string forKey:key];
}


- (void)ax_setStringArray:(NSArray *(^)(NSArray<NSString *> *cachedArray))block forKey:(NSString *)key{
    [self ax_setArray:block forKey:key];
}

- (void)ax_setArray:(NSArray *(^)(NSArray *cachedArray))block forKey:(NSString *)key{
    if (block) {
        NSMutableArray *arrM = [NSMutableArray array];
        NSArray *arr = block(arrM);
        [self setObject:arr ?: arrM forKey:key];
    }
}

- (void)ax_setDictionary:(NSDictionary *(^)(NSMutableDictionary <NSString *, id> * dict))block forKey:(NSString *)key{
    if (block) {
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        NSDictionary *dict = block(dictM);
        [self setObject:dict ?: dictM forKey:key];
    }
}
- (void)ax_setURL:(NSURL *)url forKey:(NSString *)key{
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


