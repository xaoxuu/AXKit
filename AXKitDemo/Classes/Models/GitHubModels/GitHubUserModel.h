//
//  GitHubUserModel.h
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GitHubLabelModel;

@interface GitHubUserModel : NSObject

// @xaoxuu: login
@property (copy, nonatomic) NSString *login;
// @xaoxuu: avatar_url
@property (copy, nonatomic) NSString *avatar_url;
// @xaoxuu: url
@property (copy, nonatomic) NSString *url;
// @xaoxuu: html_url
@property (copy, nonatomic) NSString *html_url;
// @xaoxuu: followers_url
@property (copy, nonatomic) NSString *followers_url;
// @xaoxuu: following_url
@property (copy, nonatomic) NSString *following_url;
// @xaoxuu: repos_url
@property (copy, nonatomic) NSString *repos_url;



@end
