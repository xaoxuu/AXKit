//
//  GitHubIssueModel.h
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GitHubUserModel,GitHubLabelModel,GitHubIssueModel;

@interface GitHubIssueListModel : NSObject

// @xaoxuu: total_count
@property (copy, nonatomic) NSString *total_count;

// @xaoxuu: items
@property (strong, nonatomic) NSMutableArray<GitHubIssueModel *> *items;

+ (instancetype)modelWithModelItems:(NSArray<GitHubIssueModel *> *)items;

@end

@interface GitHubIssueModel : NSObject



// @xaoxuu: url
@property (copy, nonatomic) NSString *url;
// @xaoxuu: number
@property (copy, nonatomic) NSString *number;
// @xaoxuu: title
@property (copy, nonatomic) NSString *title;
// @xaoxuu: html_url
@property (copy, nonatomic) NSString *html_url;
// @xaoxuu: user
@property (strong, nonatomic) GitHubUserModel *user;

// @xaoxuu: labels
@property (strong, nonatomic) NSMutableArray<GitHubLabelModel *> *labels;

// @xaoxuu: state
@property (copy, nonatomic) NSString *state;
// @xaoxuu: comments
@property (copy, nonatomic) NSString *comments;
// @xaoxuu: created_at
@property (copy, nonatomic) NSString *created_at;
// @xaoxuu: updated_at
@property (copy, nonatomic) NSString *updated_at;
// @xaoxuu: closed_at
@property (copy, nonatomic) NSString *closed_at;

// @xaoxuu: body
@property (copy, nonatomic) NSString *body;




@end
