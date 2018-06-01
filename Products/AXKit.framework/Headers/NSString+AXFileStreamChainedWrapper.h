//
//  NSString+AXFileStreamChainedWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXFileOperationResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AXFileStreamChainedWrapper)

// MARK: - read

// MARK: data

/**
 读取一个data
 */
- (nullable NSData *(^)(void))readData;
/**
 读取一个data
 */
- (nullable NSData *(^)(NSDataReadingOptions options))readDataWithOptions;
/**
 读取一个data
 */
- (AXFileOperationResult *(^)(void))readDataResult;
/**
 读取一个data
 */
- (AXFileOperationResult *(^)(NSDataReadingOptions options))readDataWithOptionsResult;

// MARK: array

/**
 读取一个数组或可变数组

 @return 数组
 */
- (nullable __kindof NSArray *(^)(void))readArray;
/**
 读取一个数组或可变数组
 
 @return 数组
 */
- (AXFileOperationResult *(^)(void))readArrayResult;

// MARK: dictionary

/**
 读取一个字典或可变字典

 @return 字典
 */
- (nullable __kindof NSDictionary *(^)(void))readDictionary;
/**
 读取一个字典或可变字典
 
 @return 字典
 */
- (AXFileOperationResult *(^)(void))readDictionaryResult;

// MARK: json

/**
 读取一个json文件

 @return 数组或字典
 */
- (nullable id (^)(void))readJson;
/**
 读取一个json文件
 
 @return 数组或字典
 */
- (AXFileOperationResult *(^)(void))readJsonResult;

// MARK: string

/**
 读取一个纯文本文件

 @return txt文件
 */
- (nullable NSString *(^)(void))readString;
/**
 读取一个纯文本文件
 
 @return txt文件
 */
- (AXFileOperationResult *(^)(void))readStringResult;

// MARK: archive/unarchive

/**
 解档一个已归档的文件
 
 @return 文件
 */
- (nullable id (^)(void))unarchiveObject;

/**
 解档一个已归档的文件
 
 @return 文件
 */
- (AXFileOperationResult *(^)(void))unarchiveObjectResult;

// MARK: - save

/**
 保存一个文件
 
 @return 操作结果
 */
- (AXFileOperationResult *(^)(id))saveObject;
/**
 保存一个json对象（数组、字典）
 
 @return 操作结果
 */
- (AXFileOperationResult *(^)(id))saveJson;

/**
 归档一个实现NSCoding协议的文件
 
 @return 操作结果
 */
- (AXFileOperationResult *(^)(NSObject<NSCoding> *))archiveObject;

/**
 拼接文本到沙盒文件
 
 @return 操作结果
 */
- (AXFileOperationResult *(^)(NSString *))appendStringToFile;


// MARK: - remove

/**
 删除一个文件

 @return 操作结果
 */
- (AXFileOperationResult *(^)(void))removeFile;

#pragma mark - path

/**
 ‘self’在mainBundle中的完整路径

 @return ‘self’在mainBundle中的完整路径
 */
- (nullable NSString *)mainBundlePath;

/**
 ‘self’在documents中的完整路径

 @return ‘self’在documents中的完整路径
 */
- (NSString *)docPath;

/**
 ‘self’在cache中的完整路径

 @return ‘self’在cache中的完整路径
 */
- (NSString *)cachePath;

/**
 ‘self’在tmp中的完整路径

 @return ‘self’在tmp中的完整路径
 */
- (NSString *)tmpPath;

/**
 ‘self’在NSSearchPathDirectory中的完整路径
 
 @return ‘self’在NSSearchPathDirectory中的完整路径
 */
- (NSString *(^)(NSSearchPathDirectory))path;

/**
 ‘self’路径下的所有文件路径
 */
- (nullable NSArray<NSString *> *(^)(NSString * __nullable))subpaths;

/**
 追加一个扩展名
 */
- (NSString *(^)(NSString * __nullable))extension;

/**
 创建路径是否存在
 
 @return 创建路径是否存在
 */
- (BOOL (^)(void))isDirectoryExist;

/**
 如果不存在创建路径
 
 @return 路径
 */
- (AXFileOperationResult *(^)(void))createDirectory;


@end

NS_ASSUME_NONNULL_END

