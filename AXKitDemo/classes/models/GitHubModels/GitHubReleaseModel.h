//
//  GitHubReleaseModel.h
//  AXKit
//
//  Created by xaoxuu on 29/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubReleaseModel : NSObject



// @xaoxuu: url
@property (copy, nonatomic) NSString *url;
// @xaoxuu: name
@property (copy, nonatomic) NSString *name;
// @xaoxuu: tag_name
@property (copy, nonatomic) NSString *tag_name;
// @xaoxuu: html_url
@property (copy, nonatomic) NSString *html_url;
// @xaoxuu: user
@property (strong, nonatomic) GitHubUserModel *user;

// @xaoxuu: prerelease
@property (assign, nonatomic) BOOL prerelease;

// @xaoxuu: created_at
@property (copy, nonatomic) NSString *created_at;
// @xaoxuu: published_at
@property (copy, nonatomic) NSString *published_at;

// @xaoxuu: body
@property (copy, nonatomic) NSString *body;




@end
