//
//  GitHubServices.h
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"
#import "GitHubModels.h"

@interface GitHubServices : BaseServices


- (void)getAllIssuesList:(void (^)(GitHubIssueListModel *issues))completion;

- (void)getHelpIssuesList:(void (^)(GitHubIssueListModel *issues))completion;

- (void)queryHelpIssuesListWithKeyword:(NSString *)keyword completion:(void (^)(GitHubIssueListModel *issues))completion;


@end
