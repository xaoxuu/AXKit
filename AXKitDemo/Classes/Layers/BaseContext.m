//
//  BaseContext.m
//  AXKitDemo
//
//  Created by xaoxuu on 2018/4/8.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "BaseContext.h"

BaseContext *instance = nil;

@implementation BaseContext


+ (instancetype)sharedInstance{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[self alloc] init];
        });
    }
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        
        
        
    }
    return self;
}


+ (BOOL)isChinese{
    NSString *languageCode = [NSLocale currentLocale].languageCode;
    if ([languageCode isEqualToString:@"zh"]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)docsURLString{
    NSString *urlString = @"https://xaoxuu.com/docs/axkit";
    if (self.isChinese) {
        urlString = [urlString stringByAppendingString:@"/#/zh-cn"];
    }
    return urlString;
}

@end
