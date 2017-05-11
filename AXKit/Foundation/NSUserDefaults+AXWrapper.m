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


static inline NSUserDefaults *DefaultUser(){
    return [NSUserDefaults standardUserDefaults];
}
@implementation NSError (AXUserDefaults)

+ (instancetype)ax_errorWithReason:(NSString *(^)())reason{
    return [NSError ax_errorWithDomain:^NSErrorDomain _Nonnull{
        return AXKitErrorDomain;
    } code:AXKitErrorCodeObjectForKeyNotFound description:nil reason:^NSString * _Nonnull{
        return reason();
    } suggestion:nil];
}

@end

@implementation NSUserDefaults (AXWrapper)


#pragma mark - read

+ (nullable id)ax_readObjectForKey:(NSString *)key{
    return [DefaultUser() objectForKey:key];
}

+ (void)ax_readObjectForKey:(NSString *)key completion:(void (^)(id object))completion fail:(void (^)(NSError *error))fail{
    id obj = [self ax_readObjectForKey:key];
    if (obj && completion) {
        completion(obj);
    } else {
        NSError *error = [NSError ax_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The object for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (fail && error) {
            fail(error);
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

+ (void)ax_readDataForKey:(NSString *)key completion:(void (^)(NSData *data))completion fail:(void (^)(NSError *error))fail{
    NSData *data = [self ax_readDataForKey:key];
    if (data && completion) {
        completion(data);
    } else {
        NSError *error = [NSError ax_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The data for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (fail && error) {
            fail(error);
        }
    }
}

+ (nullable NSString *)ax_readStringForKey:(NSString *)key{
    return [DefaultUser() stringForKey:key];
}

+ (void)ax_readStringForKey:(NSString *)key completion:(void (^)(NSString *string))completion fail:(void (^)(NSError *error))fail{
    NSString *string = [self ax_readStringForKey:key];
    if (string && completion) {
        completion(string);
    } else {
        NSError *error = [NSError ax_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The string for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (fail && error) {
            fail(error);
        }
    }
}

+ (nullable NSArray<NSString *> *)ax_readStringArrayForKey:(NSString *)key{
    return [DefaultUser() stringArrayForKey:key];
}

+ (void)ax_readStringArrayForKey:(NSString *)key completion:(void (^)(NSArray<NSString *> *string))completion fail:(void (^)(NSError *error))fail{
    NSArray<NSString *> *stringArray = [self ax_readStringArrayForKey:key];
    if (stringArray && completion) {
        completion(stringArray);
    } else {
        NSError *error = [NSError ax_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The array for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (fail && error) {
            fail(error);
        }
    }
}

+ (nullable NSArray *)ax_readArrayForKey:(NSString *)key{
    return [DefaultUser() arrayForKey:key];
}

+ (void)ax_readArrayForKey:(NSString *)key completion:(void (^)(NSArray *array))completion fail:(void (^)(NSError *error))fail{
    NSArray *array = [self ax_readArrayForKey:key];
    if (array && completion) {
        completion(array);
    } else {
        NSError *error = [NSError ax_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The array for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (fail && error) {
            fail(error);
        }
    }
}

+ (nullable NSDictionary<NSString *, id> *)ax_readDictionaryForKey:(NSString *)key{
    return [DefaultUser() dictionaryForKey:key];
}

+ (void)ax_readDictionaryForKey:(NSString *)key completion:(void (^)(NSDictionary *dictionary))completion fail:(void (^)(NSError *error))fail{
    NSDictionary *dictionary = [self ax_readDictionaryForKey:key];
    if (dictionary && completion) {
        completion(dictionary);
    } else {
        NSError *error = [NSError ax_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The dictionary for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (fail && error) {
            fail(error);
        }
    }
}

+ (NSDictionary<NSString *, id> *)ax_readDictionaryWithValuesForKeys:(NSArray<NSString *> *)keys{
    return [DefaultUser() dictionaryWithValuesForKeys:keys];
}

+ (nullable NSURL *)ax_readURLForKey:(NSString *)key{
    return [DefaultUser() URLForKey:key];
}


+ (void)ax_readURLForKey:(NSString *)key completion:(void (^)(NSURL *url))completion fail:(void (^)(NSError *error))fail{
    NSURL *url = [self ax_readURLForKey:key];
    if (url && completion) {
        completion(url);
    } else {
        NSError *error = [NSError ax_errorWithReason:^NSString *{
            return [NSString stringWithFormat:@"The url for key: \'%@\' not found.\n",key];
        }];
        AXLogError(error);
        if (fail && error) {
            fail(error);
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



#pragma mark - private 



@end


