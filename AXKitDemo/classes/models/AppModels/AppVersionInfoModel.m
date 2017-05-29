//
//  AppVersionInfoModel.m
//  AXKit
//
//  Created by xaoxuu on 29/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AppVersionInfoModel.h"

@implementation AppVersionInfoModel

- (instancetype)init{
    if (self = [super init]) {
        _name = @"0.0.0";
    }
    return self;
}

+ (AppVersionInfoModel *)versionWithModel:(GitHubIssueModel *)model{
    AppVersionInfoModel *version = [AppVersionInfoModel new];
    // @xaoxuu: 版本号
    if ([model.title containsString:@" "]) {
        version.name = [model.title substringToIndex:[model.title rangeOfString:@" "].location];
    }
    // @xaoxuu: build
    version.date = [model.updated_at substringToIndex:10];
    // @xaoxuu: log
    NSMutableString *log = [NSMutableString string];
    __block int i = 1;
    NSArray<NSString *> *components = [model.body componentsSeparatedByString:@"### "];
    [components enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.length && [obj containsString:@"\n"]) {
            NSString *info = [obj substringToIndex:[obj rangeOfString:@"\n"].location];
            if (info.length && [info containsString:@"\r"]) {
                info = [info substringToIndex:[info rangeOfString:@"\r"].location];
            }
            [log appendFormat:@"%d. %@\n",i++, info];
        }
    }];
    version.log = log;
    return version;
}

+ (NSString *)versionDescriptionWithModel:(AppVersionInfoModel *)model{
    NSMutableString *desc = [NSMutableString string];
    [desc appendFormat:NSLocalizedString(@"版本：%@\n",nil), model.name];
    [desc appendFormat:NSLocalizedString(@"发布日期：%@\n",nil), model.date];
    [desc appendFormat:NSLocalizedString(@"更新内容：%@",nil), model.log];
    
    return desc;
}

@end
