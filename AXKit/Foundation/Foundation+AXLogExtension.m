//
//  Foundation+AXLogExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "Foundation+AXLogExtension.h"
#import "NSString+AXFileStreamChainedWrapper.h"
#import "NSDate+AXExtension.h"




static LogTypeString *app = @"app";
static LogTypeString *data = @"data";
static LogTypeString *error = @"error";

// 日志文件扩展名
static NSString *logFileExtension = @"log";

// 日志存放的文件夹名
static NSString *logFileDirName = @"Logs";

static NSDateFormatter *formatter;

static inline dispatch_queue_t logQueue(){
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.xaoxuu.AXKit.log", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(queue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    });
    return queue;
}

static inline NSDateFormatter *dateFormatter(NSString *format){
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    formatter.dateFormat = format;
    return formatter;
}

static inline NSString *getTodayString(){
    return [dateFormatter(@"yyyy-MM-dd") stringFromDate:[NSDate date]];
}

static inline NSString *getCurrentTimeString(){
    return [dateFormatter(@"yyyy-MM-dd HH:mm:ss Z") stringFromDate:[NSDate date]];
}

static inline NSString *logDir(){
    static NSString *dir;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dir = [NSString stringWithFormat:@"com.xaoxuu.AXKit/%@", logFileDirName].cachePath;
        dir.createDirectory();
    });
    return dir;
}

/**
 当天的log文件夹

 @return 当天的log文件夹
 */
static inline NSString *logDirToday(){
    NSString *dir = [NSString stringWithFormat:@"%@/%@", logDir(), getTodayString()];
    if (!dir.isDirectoryExist) {
        dir.createDirectory();
    }
    return dir;
}


static inline NSString *logPath(LogTypeString *type){
    NSString *path = [NSString stringWithFormat:@"%@/%@-%@.%@", logDirToday(), getTodayString(), type, logFileExtension];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        // 初始化写入第一行，记录启动时间
        path.appendStringToFile([NSString stringWithFormat:@"-> [%@] application load completed. \n\n", getCurrentTimeString()]);
    }
    return path;
}


@implementation AXCachedLog



/**
 获取所有的日志路径
 
 @return 日志路径
 */
+ (NSArray<NSString *> *)getAllCachedLogPath{
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];
    NSArray<NSString *> *results = logDir().subpaths(logFileExtension);
    if (results.count) {
        results = [results sortedArrayUsingDescriptors:@[descriptor]];
    }
    return results;
}


/**
 获取某个日期以后的日志路径
 
 @param date 日期
 @return 日志路径
 */
+ (NSArray<NSString *> *)getLatestCachedLogPathSinceDate:(NSDate *)date{
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];
    NSArray<NSString *> *dirArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logDir() error:nil];
    dirArr = [dirArr sortedArrayUsingDescriptors:@[descriptor]];
    NSMutableArray<NSString *> *tmp = [NSMutableArray array];
    [dirArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@".DS_Store"]) {
            NSString *dateString = obj.lastPathComponent.stringByDeletingPathExtension;
            NSDate *thisDate = [dateFormatter(@"yyyy-MM-dd") dateFromString:dateString];
            if (thisDate.integerValue >= date.integerValue) {
                [tmp addObject:obj];
            }
        }
    }];
    NSMutableArray<NSString *> *ret = [NSMutableArray array];
    [tmp enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *path = [NSString stringWithFormat:@"%@/%@", logDir(), obj];
        [ret addObjectsFromArray:path.subpaths(logFileExtension)];
    }];
    
    return ret;
}

/**
 获取最近几天的日志路径
 
 @param count 天数
 @return 日志路径
 */
+ (NSArray<NSString *> *)getLatestCachedLogPathWithDateCount:(NSUInteger)count{
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];
    NSArray<NSString *> *dirArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logDir() error:nil];
    dirArr = [dirArr sortedArrayUsingDescriptors:@[descriptor]];
    NSMutableArray<NSString *> *result = [NSMutableArray arrayWithCapacity:count];
    [dirArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@".DS_Store"]) {
            [result addObject:obj];
        }
    }];
    if (result.count > count) {
        dirArr = [result subarrayWithRange:NSMakeRange(0, count)];
    }
    NSMutableArray<NSString *> *ret = [NSMutableArray array];
    [dirArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *path = [NSString stringWithFormat:@"%@/%@", logDir(), obj];
        [ret addObjectsFromArray:path.subpaths(logFileExtension)];
    }];
    return ret;
}

/**
 根据路径读取某个日志内容
 
 @param path 日志路径
 @return 日志内容
 */
+ (NSString *)getLogStringWithPath:(NSString *)path{
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

+ (void)writeAppLogWithFunc:(const char *)func input:(NSObject *)input{
    return [self writeLogWithType:app func:func input:input];
}
+ (void)writeDataLogWithFunc:(const char *)func input:(NSObject *)input{
    return [self writeLogWithType:data func:func input:input];
}
+ (void)writeErrorLogWithFunc:(const char *)func input:(NSObject *)input{
    return [self writeLogWithType:error func:func input:input];
}
/**
 写日志（每次启动保存一份日志文件，文件名为启动时间）
 要在日志中记录更详细的内容，需要重写输入对象的-description方法。
 
 @param func __FUNCTION__
 @param input 输入obj
 */
+ (void)writeLogWithType:(LogTypeString *)type func:(const char *)func input:(nullable NSObject *)input{
    if (!input) {
        return;
    }
    dispatch_async(logQueue(), ^{
        // @xaoxuu: in log queue
        NSString *str = [NSString stringWithFormat:@"-> [%@] func:%@\n%@\n\n", getCurrentTimeString(), [NSString stringWithFormat:@"%s", func], input.description];
#ifdef DEBUG
        NSLog(@"%@",str);
#endif
        logPath(type).appendStringToFile(str);
    });
}

@end

// @xaoxuu: log字典
@implementation NSDictionary (AXLogExtension)

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{\n"];
    // for-in all key-value
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    [str appendString:@"}"];
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end

// @xaoxuu: log数组
@implementation NSArray (AXLogExtension)
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"[\n"];
    // for-in all objects
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    [str appendString:@"]"];
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end

