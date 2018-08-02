//
//  AXResult.m
//  AXKit
//
//  Created by xaoxuu on 2018/5/31.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "AXResult.h"
#import "NSObject+AXJsonAdd.h"
#import "NSArray+AXAdd.h"
#import "NSDictionary+AXAdd.h"


@implementation AXResult

// MARK: 实例化

/**
 空的结果（失败，未知错误信息）
 
 @param path 路径
 @return 结果
 */
+ (AXResult *)resultWithPath:(NSString *)path{
    return [[AXResult alloc] initWithPath:path];
}
- (instancetype)initWithPath:(NSString *)path{
    if (self = [super init]) {
        _path = path;
    }
    return self;
}

/**
 bool类型的结果
 
 @param path 路径
 @param callback 回调
 @return 结果
 */
+ (AXResult *)resultWithPath:(NSString *)path boolResult:(BOOL (^)(NSError **error))callback{
    return [[self alloc] initWithPath:path boolResult:callback];
}
- (AXResult *)initWithPath:(NSString *)path boolResult:(BOOL (^)(NSError **error))callback{
    if (self = [self initWithPath:path]) {
        NSError *error = nil;
        if (callback) {
            _success = callback(&error);
            _error = error;
        }
    }
    return self;
}

/**
 id类型的结果
 
 @param path 路径
 @param callback 回调
 @return 结果
 */
+ (AXResult *)resultWithPath:(NSString *)path idResult:(id (^)(NSError *__autoreleasing *))callback{
    return [[self alloc] initWithPath:path idResult:callback];
}
- (AXResult *)initWithPath:(NSString *)path idResult:(id (^)(NSError *__autoreleasing *))callback{
    if (self = [self initWithIdResult:callback]) {
        _path = path;
    }
    return self;
}
+ (AXResult *)resultWithIdResult:(id  _Nonnull (^)(NSError * _Nullable __autoreleasing * _Nullable))callback{
    return [[self alloc] initWithIdResult:callback];
}
- (AXResult *)initWithIdResult:(id  _Nonnull (^)(NSError * _Nullable __autoreleasing * _Nullable))callback{
    if (self = [super init]) {
        NSError *error = nil;
        if (callback) {
            [self setupValue:callback(&error)];
            _error = error;
            _success = !error;
        }
    }
    return self;
}
+ (AXResult *)resultWithJsonWritingOptions:(NSJSONWritingOptions)opt object:(id  _Nonnull (^)(NSError * _Nullable __autoreleasing * _Nullable))callback{
    return [[self alloc] initWithJsonObject:opt object:callback];
}
- (AXResult *)initWithJsonObject:(NSJSONWritingOptions)opt object:(id  _Nonnull (^)(NSError * _Nullable __autoreleasing * _Nullable))callback{
    if (self = [super init]) {
        NSError *error = nil;
        if (callback) {
            _dataValue = [self readJsonObject:callback(&error) opt:opt error:&error];
            if (_dataValue && !_stringValue) {
                _stringValue = [[NSString alloc] initWithData:_dataValue encoding:NSUTF8StringEncoding];
            }
            _error = error;
            _success = !error;
        }
    }
    return self;
}
+ (AXResult *)resultWithJsonReadingOptions:(NSJSONReadingOptions)opt data:(NSData *(^)(NSError **error))callback{
    return [[self alloc] initWithJsonReadingOptions:opt data:callback];
}

- (AXResult *)initWithJsonReadingOptions:(NSJSONReadingOptions)opt data:(NSData *(^)(NSError **error))callback{
    if (self = [super init]) {
        NSError *error = nil;
        if (callback) {
            id ret = [self readJsonData:callback(&error) opt:opt error:&error];
            if (_dataValue) {
                _dictionaryValue = NSDictionary.safeDictionary(ret, nil);
                _arrayValue = NSArray.safeArray(ret, nil);
                _stringValue = [[NSString alloc] initWithData:_dataValue encoding:NSUTF8StringEncoding];
            }
            _error = error;
            _success = !error;
        }
    }
    return self;
}
/**
 设置值

 @param value 值
 */
- (void)setupValue:(id)value{
    _value = value;
    
    _numberValue = NSNumber.autoNumber(value, nil);
    _stringValue = NSString.autoString(value, nil);
    _arrayValue = NSArray.safeArray(value, nil);
    _dictionaryValue = NSDictionary.safeDictionary(value, nil);
    _dataValue = [value isKindOfClass:NSData.class]?value:nil;
    
}

- (nullable NSData *)readJsonObject:(id)obj opt:(NSJSONWritingOptions)opt error:(NSError **)error{
    [self setupValue:obj];
    if ([NSJSONSerialization isValidJSONObject:obj]) {
        return [NSJSONSerialization dataWithJSONObject:obj options:opt error:error];
    } else {
        return nil;
    }
}

- (nullable id)readJsonData:(NSData *)data opt:(NSJSONReadingOptions)opt error:(NSError **)error{
    _value = data;
    _dataValue = [data isKindOfClass:NSData.class]?data:nil;
    if (_dataValue) {
        // 验证是否是jsondata
        id ret = [NSJSONSerialization JSONObjectWithData:_dataValue options:opt error:error];
        if ([ret isKindOfClass:[NSDictionary class]] || [ret isKindOfClass:[NSArray class]]) {
            return ret;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

// MARK: - 解析

/**
 操作完成的回调，此回调必然执行。
 
 @param block 回调
 @return 结果
 */
- (AXResult *)completed:(void (^)(BOOL success))block{
    if (block) {
        block(self.success);
    }
    return self;
}

/**
 错误信息回调，只有当error有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)error:(void (^)(NSError * _Nullable))block{
    if (block && self.error) {
        block(self.error);
    }
    return self;
}

/**
 value值，只有当value有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)value:(void (^)(id value))block{
    if (block && self.value) {
        block(self.value);
    }
    return self;
}

/**
 number值，只有当numberValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)numberValue:(void (^)(NSNumber * numberValue))block{
    if (block && self.numberValue) {
        block(self.numberValue);
    }
    return self;
}

/**
 string值，只有当stringValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)stringValue:(void (^)(NSString *))block{
    if (block && self.stringValue) {
        block(self.stringValue);
    }
    return self;
}

/**
 array值，只有当arrayValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)arrayValue:(void (^)(NSArray *))block{
    if (block && self.arrayValue) {
        block(self.arrayValue);
    }
    return self;
}

/**
 dictionary值，只有当dictionaryValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)dictionaryValue:(void (^)(NSDictionary *))block{
    if (block && self.dictionaryValue) {
        block(self.dictionaryValue);
    }
    return self;
}

/**
 data值，只有当dataValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)dataValue:(void (^)(NSData *))block{
    if (block && self.dataValue) {
        block(self.dataValue);
    }
    return self;
}

@end
