//
//  AXResult.h
//  AXKit
//
//  Created by xaoxuu on 2018/5/31.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/**
 文件操作结果
 */
@interface AXResult : NSObject

/**
 路径
 */
@property (copy, readonly, nonatomic) NSString *path;

/**
 结果：成功、失败
 */
@property (assign, readonly, nonatomic) BOOL success;

/**
 错误信息
 */
@property (strong, readonly, nullable, nonatomic) NSError *error;


// MARK: 值

/**
 id值
 */
@property (strong, readonly, nullable, nonatomic) id value;
/**
 number值，只有当id值为number类型时，numberValue才有值
 */
@property (copy, readonly, nullable, nonatomic) NSNumber *numberValue;
/**
 string值，只有当id值为string类型时，stringValue才有值
 */
@property (copy, readonly, nullable, nonatomic) NSString *stringValue;

/**
 array值，只有当id值为array类型时，arrayValue才有值
 */
@property (strong, readonly, nullable, nonatomic) NSArray *arrayValue;

/**
 dictionary值，只有当id值为dictionary类型时，dictionaryValue才有值
 */
@property (strong, readonly, nullable, nonatomic) NSDictionary *dictionaryValue;

/**
 data值，只有当id值为data类型时，dataValue才有值
 */
@property (strong, readonly, nullable, nonatomic) NSData *dataValue;


// MARK: 实例化

/**
 空的结果（失败，未知错误信息）

 @param path 路径
 @return 结果
 */
+ (AXResult *)resultWithPath:(NSString *)path;

/**
 bool类型的结果

 @param path 路径
 @param callback 回调
 @return 结果
 */
+ (AXResult *)resultWithPath:(NSString *)path boolResult:(BOOL (^)(NSError **error))callback;

/**
 id类型的结果
 
 @param path 路径
 @param callback 回调
 @return 结果
 */
+ (AXResult *)resultWithPath:(NSString *)path idResult:(id (^)(NSError **error))callback;

/**
 id类型的结果
 
 @param callback 回调
 @return 结果
 */
+ (AXResult *)resultWithIdResult:(id (^)(NSError **error))callback;

/**
 json对象转data

 @param opt options
 @param callback 回调
 @return 结果
 */
+ (AXResult *)resultWithJsonWritingOptions:(NSJSONWritingOptions)opt object:(id (^)(NSError **error))callback;

/**
 data转json对象

 @param opt options
 @param callback 回调
 @return 结果
 */
+ (AXResult *)resultWithJsonReadingOptions:(NSJSONReadingOptions)opt data:(NSData *(^)(NSError **error))callback;

// MARK: - 解析

/**
 操作完成的回调，此回调必然执行。
 
 @param block 回调
 @return 结果
 */
- (AXResult *)completed:(void (^)(BOOL success))block;

/**
 错误信息回调，只有当error有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)error:(void (^)(NSError * _Nullable error))block;

/**
 value值，只有当value有值时才会进入此回调

 @param block 回调
 @return 结果
 */
- (AXResult *)value:(void (^)(id value))block;

/**
 number值，只有当numberValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)numberValue:(void (^)(NSNumber * numberValue))block;

/**
 string值，只有当stringValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)stringValue:(void (^)(NSString * stringValue))block;

/**
 array值，只有当arrayValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)arrayValue:(void (^)(NSArray * arrayValue))block;

/**
 dictionary值，只有当dictionaryValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)dictionaryValue:(void (^)(NSDictionary * dictionaryValue))block;

/**
 data值，只有当dataValue有值时才会进入此回调
 
 @param block 回调
 @return 结果
 */
- (AXResult *)dataValue:(void (^)(NSData *dataValue))block;


@end
NS_ASSUME_NONNULL_END
