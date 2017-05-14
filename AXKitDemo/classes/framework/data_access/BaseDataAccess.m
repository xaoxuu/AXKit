//
//  BaseDataAccess.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseDataAccess.h"

@interface BaseDataAccess ()

// @xaoxuu: json file
@property (strong, nonatomic) NSDictionary *appConfig;
// @xaoxuu: github config
@property (strong, nonatomic) NSDictionary *githubConfig;

@end

@implementation BaseDataAccess

- (instancetype)init{
    if (self = [super init]) {
        
        // @xaoxuu: app config
        _homePageURL = self.appConfig[@"homePageURL"];
        _blogURL = self.appConfig[@"blogURL"];
        _feedbackURL = self.appConfig[@"feedbackURL"];
        _feedbackEmail = self.appConfig[@"feedbackEmail"];
        
        // @xaoxuu: github config
        _gitBaseURL = self.githubConfig[@"apiBaseURL"];
        _gitAXKitURL = self.githubConfig[@"axkitURL"];
        _gitIssuesURL = self.githubConfig[@"issuesURL"];
        _gitIssueHelpURL = self.githubConfig[@"helpURL"];
        
    }
    return self;
}


- (NSDictionary *)appConfig{
    if (!_appConfig) {
        _appConfig = @"app_config".mainBundlePath.readJson;
    }
    return _appConfig;
}

- (NSDictionary *)githubConfig{
    if (!_githubConfig) {
        _githubConfig = @"github_config".mainBundlePath.readJson;
    }
    return _githubConfig;
}


@end
