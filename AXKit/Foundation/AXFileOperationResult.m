//
//  AXFileOperationResult.m
//  AXKit
//
//  Created by xaoxuu on 2018/5/31.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "AXFileOperationResult.h"


@implementation AXFileOperationResult

// MARK: 实例化

/**
 空的结果（失败，未知错误信息）
 
 @param path 路径
 @return 结果
 */
+ (AXFileOperationResult *)resultWithPath:(NSString *)path{
    return [[AXFileOperationResult alloc] initWithPath:path];
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
+ (AXFileOperationResult *)resultWithPath:(NSString *)path boolResult:(BOOL (^)(NSError **error))callback{
    return [[self alloc] initWithPath:path boolResult:callback];
}
- (AXFileOperationResult *)initWithPath:(NSString *)path boolResult:(BOOL (^)(NSError **error))callback{
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
+ (AXFileOperationResult *)resultWithPath:(NSString *)path idResult:(id (^)(NSError *__autoreleasing *))callback{
    return [[self alloc] initWithPath:path idResult:callback];
}
- (AXFileOperationResult *)initWithPath:(NSString *)path idResult:(id (^)(NSError *__autoreleasing *))callback{
    if (self = [self initWithPath:path]) {
        NSError *error = nil;
        if (callback) {
            [self setupValue:callback(&error)];
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
    
    _stringValue = [value isKindOfClass:NSString.class]?(NSString *)value:nil;
    _arrayValue = [value isKindOfClass:NSArray.class]?(NSArray *)value:nil;
    _dictionaryValue = [value isKindOfClass:NSDictionary.class]?(NSDictionary *)value:nil;
    _dataValue = [value isKindOfClass:NSData.class]?(NSData *)value:nil;
    
}


// MARK: - 解析

/**
 操作完成的回调，此回调必然执行。
 
 @param block 回调
 @return 结果
 */
- (AXFileOperationResult *)completed:(void (^)(BOOL success))block{
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
- (AXFileOperationResult *)error:(void (^)(NSError * _Nullable))block{
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
- (AXFileOperationResult *)value:(void (^)(id value))block{
    if (block && self.value) {
        block(self.value);
    }
    return self;
}

/**
 string值，只有当stringValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXFileOperationResult *)stringValue:(void (^)(NSString *))block{
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
- (AXFileOperationResult *)arrayValue:(void (^)(NSArray *))block{
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
- (AXFileOperationResult *)dictionaryValue:(void (^)(NSDictionary *))block{
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
- (AXFileOperationResult *)dataValue:(void (^)(NSData *))block{
    if (block && self.dataValue) {
        block(self.dataValue);
    }
    return self;
}

@end
