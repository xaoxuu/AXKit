//
//  AppVersionInfoModel.h
//  AXKit
//
//  Created by xaoxuu on 29/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubIssueModel.h"

typedef NS_ENUM(NSUInteger, VersionState) {
    VersionStateUnknown,
    VersionStateLatest,
    VersionStateOld,
};

@interface AppVersionInfoModel : NSObject


// @xaoxuu: version name
@property (copy, nonatomic) NSString *name;

// @xaoxuu: date
@property (copy, nonatomic) NSString *date;

// @xaoxuu: log
@property (copy, nonatomic) NSString *log;


+ (AppVersionInfoModel *)versionWithModel:(GitHubIssueModel *)model;

+ (NSString *)versionDescriptionWithModel:(AppVersionInfoModel *)model;

@end
