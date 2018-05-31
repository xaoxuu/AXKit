//
//  NSString+AXFileStreamChainedWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSString+AXFileStreamChainedWrapper.h"

// MARK: path
/**
 如果文件夹不存在就创建文件夹

 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *createDirectoryIfNeed(NSString *path){
    NSString *dir = path.stringByDeletingLastPathComponent;
    return [AXFileOperationResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:error];
    }];
}
// MARK: read
/**
 读取数组

 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *readArrayResult(NSString *path){
    return [AXFileOperationResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
        return [NSArray arrayWithContentsOfFile:path];
    }];
}

/**
 读取字典
 
 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *readDictionaryResult(NSString *path){
    return [AXFileOperationResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
        return [NSDictionary dictionaryWithContentsOfFile:path];
    }];
}

/**
 读取data
 
 @param path 路径
 @param options 操作
 @return 结果
 */
static inline AXFileOperationResult *readDataWithOptionsResult(NSString *path, NSDataReadingOptions options){
    return [AXFileOperationResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
        return [NSData dataWithContentsOfFile:path options:options error:error];
    }];
}

/**
 读取data
 
 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *readDataResult(NSString *path){
    return readDataWithOptionsResult(path, NSDataReadingMappedIfSafe);
}

/**
 读取json
 
 @param path 路径
 @param options 操作
 @return 结果
 */
static inline AXFileOperationResult *readJsonWithOptionsResult(NSString *path, NSJSONReadingOptions options){
    AXFileOperationResult *result = readDataResult(path);
    if (result.value) {
        return [AXFileOperationResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
            return [NSJSONSerialization JSONObjectWithData:result.value options:options error:error];
        }];
    } else {
        return result;
    }
}
/**
 读取json
 
 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *readJsonResult(NSString *path){
    return readJsonWithOptionsResult(path, NSJSONReadingMutableContainers);
}


/**
 读取字符串
 
 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *readStringResult(NSString *path){
    return [AXFileOperationResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
        return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:error];
    }];
}

/**
 解档
 
 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *unarchiveObjectAtPath(NSString *path){
    return [AXFileOperationResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data.length) {
            return [NSKeyedUnarchiver unarchiveObjectWithData:data];
        } else{
            return nil;
        }
    }];
}

// MARK: save
/**
 归档
 
 @param obj 操作对象
 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *archiveObjectAtPath(id obj, NSString *path){
    createDirectoryIfNeed(path);
    [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    // save contents to file
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    return [AXFileOperationResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
        return [data writeToFile:path atomically:YES];
    }];
}

/**
 字符串文件末尾拼接字符串
 
 @param obj 操作对象
 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *appendStringToFile(NSString *obj, NSString *path){
    return [AXFileOperationResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:path];
        if (!handle) {
            path.saveObject(obj);
            handle = [NSFileHandle fileHandleForWritingAtPath:path];
            return YES;
        }
        if (handle) {
            [handle seekToEndOfFile];
            NSData *data = [obj dataUsingEncoding:NSUTF8StringEncoding];
            [handle writeData:data];
            [handle closeFile];
            return YES;
        }
        return NO;
    }];
}

/**
 保存对象
 
 @param obj 操作对象
 @param path 路径
 @return 结果
 */
static inline AXFileOperationResult *saveObjectAtPath(id obj, NSString *path){
    createDirectoryIfNeed(path);
    if ([obj isKindOfClass:NSString.class]) {
        return [AXFileOperationResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [(NSString *)obj writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:error];
        }];
    } else if ([obj isKindOfClass:NSArray.class]) {
        return [AXFileOperationResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [(NSArray *)obj writeToFile:path atomically:YES];
        }];
    } else if ([obj isKindOfClass:NSDictionary.class]) {
        return [AXFileOperationResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [(NSDictionary *)obj writeToFile:path atomically:YES];
        }];
    } else if ([obj isKindOfClass:NSData.class]) {
        return [AXFileOperationResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [(NSData *)obj writeToFile:path atomically:YES];
        }];
    } else if (obj) {
        return archiveObjectAtPath(obj, path);
    } else {
        return [AXFileOperationResult resultWithPath:path];
    }
}

/**
 保存json对象

 @param obj 对象
 @param path 路径
 @param options 操作
 @return 结果
 */
static inline AXFileOperationResult *saveJsonWithOptionsResult(id obj, NSString *path, NSJSONWritingOptions options){
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:options error:nil];
    return saveObjectAtPath(data, path);
}

@implementation NSString (AXFileStreamChainedWrapper)

#pragma mark - read

- (nullable NSData *(^)(void))readData{
    return ^NSData *{
        return readDataResult(self).dataValue;
    };
}

- (AXFileOperationResult * _Nonnull (^)(void))readDataResult{
    return ^AXFileOperationResult *{
        return readDataResult(self);
    };
}
- (nullable NSData *(^)(NSDataReadingOptions))readDataWithOptions{
    return ^NSData *(NSDataReadingOptions options){
        return readDataWithOptionsResult(self, options).dataValue;
    };
}
- (AXFileOperationResult *(^)(NSDataReadingOptions))readDataWithOptionsResult{
    return ^AXFileOperationResult *(NSDataReadingOptions options){
        return readDataWithOptionsResult(self, options);
    };
}

- (nullable __kindof NSArray *(^)(void))readArray{
    return ^NSArray *{
        return readArrayResult(self).arrayValue;
    };
}
- (AXFileOperationResult * _Nonnull (^)(void))readArrayResult{
    return ^AXFileOperationResult *{
        return readArrayResult(self);
    };
}

- (nullable __kindof NSDictionary *(^)(void))readDictionary{
    return ^NSDictionary *{
        return readDictionaryResult(self).dictionaryValue;
    };
}
- (AXFileOperationResult * _Nonnull (^)(void))readDictionaryResult{
    return ^AXFileOperationResult *{
        return readDictionaryResult(self);
    };
}

- (nullable id (^)(void))readJson{
    return ^id{
        return readJsonResult(self).value;
    };
}
- (AXFileOperationResult * _Nonnull (^)(void))readJsonResult{
    return ^AXFileOperationResult *{
        return readJsonResult(self);
    };
}

- (nullable NSString *(^)(void))readString{
    return ^NSString *{
        return readStringResult(self).stringValue;
    };
}
- (AXFileOperationResult *(^)(void))readStringResult{
    return ^AXFileOperationResult *{
        return readStringResult(self);
    };
}

- (nullable id (^)(void))unarchiveObject{
    return ^id{
        return unarchiveObjectAtPath(self).value;
    };
}
- (AXFileOperationResult *(^)(void))unarchiveObjectResult{
    return ^AXFileOperationResult *{
        return unarchiveObjectAtPath(self);
    };
}

#pragma mark - save

- (AXFileOperationResult *(^)(id))saveObject{
    return ^AXFileOperationResult *(id obj){
        return saveObjectAtPath(obj, self);
    };
}

- (AXFileOperationResult *(^)(id))saveJson{
    return ^AXFileOperationResult *(id obj){
        return saveJsonWithOptionsResult(obj, self, NSJSONWritingPrettyPrinted);
    };
}

- (AXFileOperationResult *(^)(NSObject<NSCoding> *))archiveObject{
    return ^AXFileOperationResult *(id obj){
        return archiveObjectAtPath(obj, self);
    };
}

- (AXFileOperationResult *(^)(NSString *))appendStringToFile{
    return ^AXFileOperationResult *(NSString *obj){
        return appendStringToFile(obj, self);
    };
}

#pragma mark - remove

- (AXFileOperationResult *(^)(void))removeFile{
    return ^AXFileOperationResult *{
        return [AXFileOperationResult resultWithPath:self boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [[NSFileManager defaultManager] removeItemAtPath:self error:error];
        }];
    };
}

#pragma mark - path

- (NSString *)mainBundlePath{
    return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:self];
}

- (NSString *)docPath{
    return self.path(NSDocumentDirectory);
}

- (NSString *)cachePath{
    return self.path(NSCachesDirectory);
}

- (NSString *)tmpPath{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self];
}

- (NSString *(^)(NSSearchPathDirectory))path{
    return ^(NSSearchPathDirectory searchPathDirectory){
        NSString *path = NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES)[0];
        return [path stringByAppendingPathComponent:self];
    };
}

- (NSArray<NSString *> *(^)(NSString * __nullable))subpaths{
    return ^(NSString * __nullable extension){
        NSMutableArray *allPlist = [NSMutableArray array];
        NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:self];
        NSString *path;
        while ((path = dirEnum.nextObject) != nil) {
            if (!extension.length || [path.lastPathComponent containsString:extension]) {
                [allPlist addObject:[self stringByAppendingPathComponent:path]];
            }
        }
        return allPlist;
    };
}

- (NSString *(^)(NSString * __nullable))extension{
    return ^(NSString * __nullable extension){
        if (extension.length && ![self.lastPathComponent containsString:[@"."stringByAppendingString:extension]]) {
            NSString *first = [extension substringToIndex:1];
            if ([first containsString:@"."]) {
                extension = [extension substringFromIndex:1];
            }
            return [self stringByAppendingPathExtension:extension];
        } else{
            return self;
        }
    };
}

- (BOOL (^)(void))isDirectoryExist{
    return ^{
        return [[NSFileManager defaultManager] fileExistsAtPath:self];
    };
}

- (AXFileOperationResult *(^)(void))createDirectory{
    return ^AXFileOperationResult *{
        // create dir if not exist
        return [AXFileOperationResult resultWithPath:self boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [[NSFileManager defaultManager] createDirectoryAtPath:self withIntermediateDirectories:YES attributes:nil error:error];
        }];
    };
}

@end




