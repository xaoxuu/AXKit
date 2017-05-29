//
//  GitHubInfoModel.h
//  AXKit
//
//  Created by xaoxuu on 29/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubInfoModel : NSObject



// @xaoxuu: github api
@property (copy, readonly, nonatomic) NSString *apiBaseURL;
// @xaoxuu: github axkit
@property (copy, readonly, nonatomic) NSString *axkitURL;
// @xaoxuu: issues
@property (copy, readonly, nonatomic) NSString *issuesURL;
// @xaoxuu: help
@property (copy, readonly, nonatomic) NSString *helpURL;

// @xaoxuu: 发布日志
@property (copy, readonly, nonatomic) NSString *releaseLogURL;


// @xaoxuu: blog list
@property (copy, readonly, nonatomic) NSString *blogURL;


@end
