//
//  NSString+AXFileManager.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSString+AXFileManager.h"
#import "NSObject+AXJsonAdd.h"

// MARK: path
/**
 如果文件夹不存在就创建文件夹

 @param path 路径
 @return 结果
 */
static inline AXResult *createDirectoryIfNeed(NSString *path){
    NSString *dir = path.stringByDeletingLastPathComponent;
    return [AXResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:error];
    }];
}
// MARK: read
/**
 读取数组

 @param path 路径
 @return 结果
 */
static inline AXResult *readArrayResult(NSString *path){
    return [AXResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
        return [NSArray arrayWithContentsOfFile:path];
    }];
}

/**
 读取字典
 
 @param path 路径
 @return 结果
 */
static inline AXResult *readDictionaryResult(NSString *path){
    return [AXResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
        return [NSDictionary dictionaryWithContentsOfFile:path];
    }];
}

/**
 读取data
 
 @param path 路径
 @param options 操作
 @return 结果
 */
static inline AXResult *readDataWithOptionsResult(NSString *path, NSDataReadingOptions options){
    return [AXResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
        return [NSData dataWithContentsOfFile:path options:options error:error];
    }];
}

/**
 读取data
 
 @param path 路径
 @return 结果
 */
static inline AXResult *readDataResult(NSString *path){
    return readDataWithOptionsResult(path, NSDataReadingMappedIfSafe);
}

/**
 读取json
 
 @param path 路径
 @param options 操作
 @return 结果
 */
static inline AXResult *readJsonWithOptionsResult(NSString *path, NSJSONReadingOptions options){
    AXResult *result = readDataResult(path);
    if (result.value) {
        return [AXResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
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
static inline AXResult *readJsonResult(NSString *path){
    return readJsonWithOptionsResult(path, NSJSONReadingMutableContainers);
}


/**
 读取字符串
 
 @param path 路径
 @return 结果
 */
static inline AXResult *readStringResult(NSString *path){
    return [AXResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
        return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:error];
    }];
}

/**
 解档
 
 @param path 路径
 @return 结果
 */
static inline AXResult *unarchiveObjectAtPath(NSString *path){
    return [AXResult resultWithPath:path idResult:^id(NSError *__autoreleasing *error) {
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
static inline AXResult *archiveObjectAtPath(id obj, NSString *path){
    createDirectoryIfNeed(path);
    [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    // save contents to file
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    return [AXResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
        return [data writeToFile:path atomically:YES];
    }];
}

/**
 字符串文件末尾拼接字符串
 
 @param obj 操作对象
 @param path 路径
 @return 结果
 */
static inline AXResult *appendStringToFile(NSString *obj, NSString *path){
    return [AXResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
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
static inline AXResult *saveObjectAtPath(id obj, NSString *path){
    createDirectoryIfNeed(path);
    if ([obj isKindOfClass:NSString.class]) {
        return [AXResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [(NSString *)obj writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:error];
        }];
    } else if ([obj isKindOfClass:NSArray.class]) {
        return [AXResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [(NSArray *)obj writeToFile:path atomically:YES];
        }];
    } else if ([obj isKindOfClass:NSDictionary.class]) {
        return [AXResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [(NSDictionary *)obj writeToFile:path atomically:YES];
        }];
    } else if ([obj isKindOfClass:NSData.class]) {
        return [AXResult resultWithPath:path boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [(NSData *)obj writeToFile:path atomically:YES];
        }];
    } else if (obj) {
        return archiveObjectAtPath(obj, path);
    } else {
        return [AXResult resultWithPath:path];
    }
}

/**
 保存json对象

 @param obj 对象
 @param path 路径
 @param options 操作
 @return 结果
 */
static inline AXResult *saveJsonWithOptionsResult(id obj, NSString *path, NSJSONWritingOptions options){
    NSData *data = nil;
    if ([obj isKindOfClass:NSArray.class]) {
        data = ((NSArray *)obj).jsonValue.dataValue;
    } else if ([obj isKindOfClass:NSDictionary.class]) {
        data = ((NSDictionary *)obj).jsonValue.dataValue;
    } else if ([obj isKindOfClass:NSData.class] || [obj isKindOfClass:[NSString class]]) {
        NSData *testData;
        if ([obj isKindOfClass:[NSString class]]) {
            testData = [(NSString *)obj dataUsingEncoding:NSUTF8StringEncoding];
        } else {
            testData = obj;
        }
        data = testData.jsonValue.dataValue;
    }
    if (data) {
        return saveObjectAtPath(data, path);
    } else {
        return [AXResult resultWithPath:path boolResult:^BOOL(NSError * _Nullable __autoreleasing * _Nullable error) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:3840 userInfo:nil];
            return NO;
        }];
    }
}

@implementation NSString (AXFileManager)

#pragma mark - read

- (nullable NSData *(^)(void))readData{
    return ^NSData *{
        return readDataResult(self).dataValue;
    };
}

- (AXResult * _Nonnull (^)(void))readDataResult{
    return ^AXResult *{
        return readDataResult(self);
    };
}
- (nullable NSData *(^)(NSDataReadingOptions))readDataWithOptions{
    return ^NSData *(NSDataReadingOptions options){
        return readDataWithOptionsResult(self, options).dataValue;
    };
}
- (AXResult *(^)(NSDataReadingOptions))readDataWithOptionsResult{
    return ^AXResult *(NSDataReadingOptions options){
        return readDataWithOptionsResult(self, options);
    };
}

- (nullable __kindof NSArray *(^)(void))readArray{
    return ^NSArray *{
        return readArrayResult(self).arrayValue;
    };
}
- (AXResult * _Nonnull (^)(void))readArrayResult{
    return ^AXResult *{
        return readArrayResult(self);
    };
}

- (nullable __kindof NSDictionary *(^)(void))readDictionary{
    return ^NSDictionary *{
        return readDictionaryResult(self).dictionaryValue;
    };
}
- (AXResult * _Nonnull (^)(void))readDictionaryResult{
    return ^AXResult *{
        return readDictionaryResult(self);
    };
}

- (nullable id (^)(void))readJson{
    return ^id{
        return readJsonResult(self).value;
    };
}
- (AXResult * _Nonnull (^)(void))readJsonResult{
    return ^AXResult *{
        return readJsonResult(self);
    };
}

- (nullable NSString *(^)(void))readString{
    return ^NSString *{
        return readStringResult(self).stringValue;
    };
}
- (AXResult *(^)(void))readStringResult{
    return ^AXResult *{
        return readStringResult(self);
    };
}

- (nullable id (^)(void))unarchiveObject{
    return ^id{
        return unarchiveObjectAtPath(self).value;
    };
}
- (AXResult *(^)(void))unarchiveObjectResult{
    return ^AXResult *{
        return unarchiveObjectAtPath(self);
    };
}

#pragma mark - save

- (AXResult *(^)(id))saveObject{
    return ^AXResult *(id obj){
        return saveObjectAtPath(obj, self);
    };
}

- (AXResult *(^)(id))saveJson{
    return ^AXResult *(id obj){
        return saveJsonWithOptionsResult(obj, self, NSJSONWritingPrettyPrinted);
    };
}

- (AXResult *(^)(NSObject<NSCoding> *))archiveObject{
    return ^AXResult *(id obj){
        return archiveObjectAtPath(obj, self);
    };
}

- (AXResult *(^)(NSString *))appendStringToFile{
    return ^AXResult *(NSString *obj){
        return appendStringToFile(obj, self);
    };
}

#pragma mark - remove

- (AXResult *(^)(void))removeFile{
    return ^AXResult *{
        return [AXResult resultWithPath:self boolResult:^BOOL(NSError *__autoreleasing *error) {
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

- (AXResult *(^)(void))createDirectory{
    return ^AXResult *{
        // create dir if not exist
        return [AXResult resultWithPath:self boolResult:^BOOL(NSError *__autoreleasing *error) {
            return [[NSFileManager defaultManager] createDirectoryAtPath:self withIntermediateDirectories:YES attributes:nil error:error];
        }];
    };
}

@end




