//
//  GitHubRepoModel.h
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GitHubUserModel;

@interface GitHubRepoModel : NSObject

// @xaoxuu: name
@property (copy, nonatomic) NSString *name;
// @xaoxuu: full_name(xaoxuu/AXKit)
@property (copy, nonatomic) NSString *full_name;

// @xaoxuu: owner
@property (strong, nonatomic) GitHubUserModel *owner;

// @xaoxuu: html_url
@property (copy, nonatomic) NSString *html_url;
// @xaoxuu: description
@property (copy, nonatomic) NSString *description1;
// @xaoxuu: fork
@property (copy, nonatomic) NSString *fork;
// @xaoxuu: url
@property (copy, nonatomic) NSString *url;

// @xaoxuu: branches_url
@property (copy, nonatomic) NSString *branches_url;
// @xaoxuu: tags_url
@property (copy, nonatomic) NSString *tags_url;

// @xaoxuu: contents_url
@property (copy, nonatomic) NSString *contents_url;
// @xaoxuu: issues_url
@property (copy, nonatomic) NSString *issues_url;
// @xaoxuu: labels_url
@property (copy, nonatomic) NSString *labels_url;
// @xaoxuu: releases_url
@property (copy, nonatomic) NSString *releases_url;

// @xaoxuu: created_at
@property (copy, nonatomic) NSString *created_at;
// @xaoxuu: updated_at
@property (copy, nonatomic) NSString *updated_at;
// @xaoxuu: pushed_at
@property (copy, nonatomic) NSString *pushed_at;

// @xaoxuu: git_url
@property (copy, nonatomic) NSString *git_url;

// @xaoxuu: homepage
@property (copy, nonatomic) NSString *homepage;

// @xaoxuu: open_issues_count
@property (copy, nonatomic) NSString *open_issues_count;
// @xaoxuu: forks
@property (copy, nonatomic) NSString *forks;
// @xaoxuu: open_issues
@property (copy, nonatomic) NSString *open_issues;
// @xaoxuu: watchers
@property (copy, nonatomic) NSString *watchers;
// @xaoxuu: subscribers_count
@property (copy, nonatomic) NSString *subscribers_count;

@end
