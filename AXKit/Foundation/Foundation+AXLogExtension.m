//
//  Foundation+AXLogExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Foundation+AXLogExtension.h"
#import "_AXKitHelpServices.h"
#import "NSBundle+AXExtension.h"
#import "NSString+AXFileStreamChainedWrapper.h"

// 日志存放的文件夹名
static NSString *logFileDir = @"log";
// 日志文件扩展名
static NSString *logFileExtension = @"md";

static NSString *logPath = nil;
static dispatch_queue_t queue_log;
static NSDateFormatter *formatter;

static NSDateFormatter *getDateFormatter(){
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    }
    return formatter;
}

static NSString *getLogPath(){
    if (logPath.length) {
        return logPath;
    }
    NSDate *today = [NSDate date];
    NSBundle *bundle = [NSBundle bundleForClass:[AXKitHelpServices class]];
    NSString *fileName = [NSString stringWithFormat:@"%@.%@", [getDateFormatter() stringFromDate:today], logFileExtension];
    NSString * bundleId = [bundle bundleIdentifier];
    logPath = [[bundleId stringByAppendingPathComponent:logFileDir] stringByAppendingPathComponent:fileName].cachePath;
    
    // 写入第一行，文件标题
    logPath.saveStringByAppendingToEndOfFile([NSString stringWithFormat:@"## %@\n", fileName.stringByDeletingPathExtension]);
    
    return logPath;
}


@implementation AXLog

+ (NSArray<NSString *> *)getCachedLogPath{
    return getLogPath().stringByDeletingLastPathComponent.subpaths(logFileExtension);
}

+ (NSArray<NSString *> *)getCachedLogPathSinceDate:(NSDate *)date{
    NSMutableArray<NSString *> *result = [NSMutableArray arrayWithArray:[self getCachedLogPath]];
    for (int i = 0; i < result.count; i++) {
        NSString *obj = result[i];
        NSString *dateString = obj.lastPathComponent.stringByDeletingPathExtension;
        NSDate *targetDate = [getDateFormatter() dateFromString:dateString];
        NSTimeInterval targetTimestamp = [targetDate timeIntervalSince1970];
        if (targetTimestamp < [date timeIntervalSince1970]) {
            [result removeObjectAtIndex:i];
            i--;
        }
    }
    return result;
}

+ (NSString *)readLogStringWithPath:(NSString *)path{
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];;
}

+ (void)writeLogWithFunc:(NSString *)func input:(NSObject *)input{
    if (!input) {
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%@\n```\n%@\n```\n\n", func, input.description];
#ifdef DEBUG
    NSLog(@"%@",str);
#endif
    getLogPath().saveStringByAppendingToEndOfFile(str);
}

@end

// @xaoxuu: log字典
@implementation NSDictionary (AXLogExtension)

//- (void)dsfsdf:(format)

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
