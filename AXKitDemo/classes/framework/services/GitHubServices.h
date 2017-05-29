//
//  GitHubServices.h
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"
#import "GitHubModels.h"
#import "BlogModels.h"
#import "GitHubInfoModel.h"

@interface GitHubServices : BaseServices

@property (strong, readonly, nonatomic) GitHubInfoModel *model;
/**
 获取所有issues

 @param completion 获取到的数据源
 */
- (void)getAllIssuesList:(void (^)(GitHubIssueListModel *issues))completion;

/**
 获取帮助信息

 @param completion 获取到的数据源
 */
- (void)getHelpIssuesList:(void (^)(GitHubIssueListModel *issues))completion;

/**
 查询帮助信息

 @param keyword 关键词
 @param completion 查询到的列表
 */
- (void)queryHelpIssuesListWithKeyword:(NSString *)keyword completion:(void (^)(GitHubIssueListModel *issues))completion;



/**
 获取发布日志列表

 @param completion 获取到的发布日志列表
 */
- (void)getReleaseLogList:(void (^)(GitHubIssueListModel *issues))completion;

/**
 获取博客列表

 @param completion 数据源
 */
- (void)getBlogList:(void (^)(NSArray<BlogListModel *> *blogs))completion;




@end
