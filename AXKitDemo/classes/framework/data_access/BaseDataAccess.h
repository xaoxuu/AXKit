//
//  BaseDataAccess.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDataAccess : NSObject


#pragma mark - app config
// @xaoxuu: homePage url
@property (copy, readonly, nonatomic) NSString *homePageURL;
// @xaoxuu: blog url
@property (copy, readonly, nonatomic) NSString *blogURL;
// @xaoxuu: feedback
@property (copy, readonly, nonatomic) NSString *feedbackURL;

// @xaoxuu: feedback email
@property (copy, readonly, nonatomic) NSString *feedbackEmail;



#pragma mark - github config
// @xaoxuu: github api
@property (copy, readonly, nonatomic) NSString *gitBaseURL;
// @xaoxuu: github axkit
@property (copy, readonly, nonatomic) NSString *gitAXKitURL;
// @xaoxuu: issues
@property (copy, readonly, nonatomic) NSString *gitIssuesURL;
// @xaoxuu: help
@property (copy, readonly, nonatomic) NSString *gitIssueHelpURL;


@end
