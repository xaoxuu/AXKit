//
//  GitHubServices.m
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "GitHubServices.h"

#import "DataAccessLayer.h"
#import "MJExtension.h"

#define daLayer [DataAccessLayer sharedInstance]


@implementation GitHubServices



- (instancetype)init{
    if (self = [super init]) {
        
        _model = [GitHubInfoModel mj_objectWithKeyValues:@"ghinfo".mainBundlePath.readJson];
        
    }
    return self;
}

- (void)getAllIssuesList:(void (^)(GitHubIssueListModel *issues))completion{
    daLayer.network.URLString = self.model.issuesURL;
    [daLayer.network getURLCompletion:^(id response) {
        NSArray *dataArr = response;
        NSMutableArray<GitHubIssueModel *> *list = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            GitHubIssueModel *model = [GitHubIssueModel modelWithDictionary:dict];
            if (model) {
                [list addObject:model];
            }
        }
        if (completion) {
            completion([GitHubIssueListModel modelWithModelItems:list]);
        }
    } fail:^(NSError *error) {
        
    }];
}



- (void)getHelpIssuesList:(void (^)(GitHubIssueListModel *issues))completion{
    daLayer.network.URLString = self.model.helpURL;
    [daLayer.network getURLCompletion:^(id response) {
        NSDictionary *dataDict = response;
        GitHubIssueListModel *list = [GitHubIssueListModel modelWithDictionary:dataDict];
        
        if (completion) {
            completion(list);
        }
    } fail:^(NSError *error) {
        
    }];
}


- (void)queryHelpIssuesListWithKeyword:(NSString *)keyword completion:(void (^)(GitHubIssueListModel *))completion{
    daLayer.network.URLString = [self queryURLWithKeyword:keyword];
    [daLayer.network getURLCompletion:^(id response) {
        NSDictionary *dataDict = response;
        GitHubIssueListModel *list = [GitHubIssueListModel modelWithDictionary:dataDict];
        if (completion) {
            completion(list);
        }
    } fail:^(NSError *error) {
        
    }];
}


- (void)getBlogList:(void (^)(NSArray<BlogListModel *> *blogs))completion{
    daLayer.network.URLString = self.model.blogURL;
    [daLayer.network getURLCompletion:^(id response) {
        NSArray *dataArr = response;
        NSMutableArray<BlogListModel *> *ret = [NSMutableArray array];
        for (NSDictionary *dataDict in dataArr) {
            BlogListModel *blogs = [BlogListModel modelWithDictionary:dataDict];
            if (blogs) {
                [ret addObject:blogs];
            }
            
        }
        if (completion) {
            completion(ret);
        }
    } fail:^(NSError *error) {
        
    }];
}


// @xaoxuu: 更新日志
- (void)getReleaseLogList:(void (^)(GitHubIssueListModel *issues))completion{
    daLayer.network.URLString = self.model.releaseLogURL;
    [daLayer.network getURLCompletion:^(id response) {
        NSDictionary *dataDict = response;
        GitHubIssueListModel *list = [GitHubIssueListModel modelWithDictionary:dataDict];
        
        if (completion) {
            completion(list);
        }
    } fail:^(NSError *error) {
        
    }];
}


// @xaoxuu: 更新日志
- (void)getReleaseList:(void (^)(NSMutableArray<GitHubReleaseModel *> *releaseList))completion{
    daLayer.network.URLString = self.model.releaseURL;
    [daLayer.network getURLCompletion:^(id response) {
        NSMutableArray *dataArr = [NSMutableArray arrayWithArray:response];
        for (NSInteger i=0; i<dataArr.count; i++) {
            NSDictionary *dataDict = dataArr.firstObject;
            NSString *pre = dataDict[@"prerelease"];
            if (pre.boolValue) {
                [dataArr removeFirstObject];
                i--;
            } else {
                break;
            }
        }
        
        NSMutableArray<GitHubReleaseModel *> *list = [NSMutableArray arrayWithArray:[GitHubReleaseModel mj_objectArrayWithKeyValuesArray:dataArr]];
        
        if (completion) {
            completion(list);
        }
    } fail:^(NSError *error) {
        
    }];
}

// @xaoxuu: 最新版本信息
- (void)getLatestRelease:(void (^)(GitHubReleaseModel *releaseList))completion{
    [self getReleaseList:^(NSMutableArray<GitHubReleaseModel *> *releaseList) {
        if (completion) {
            completion(releaseList.firstObject);
        }
    }];
}



#pragma mark - util




- (NSString *)queryURLWithKeyword:(NSString *)keyword{
    NSString *key = [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSMutableString *queryURL = [NSMutableString stringWithString:self.model.helpURL];
    NSRange range = [queryURL rangeOfString:@"?q="];
    [queryURL insertString:key atIndex:range.location+range.length];
    return queryURL;
}

@end
