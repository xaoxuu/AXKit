//
//  ProjectsTableView.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ProjectsTableView.h"
#import "ProjectDetailVC.h"

@implementation ProjectsTableView



- (void)setupTableViewDataSource:(void (^)(BaseTableModelListType))completion{
    if (completion) {
        completion(services.cache.projectList);
    }
}

- (BOOL)indexPath:(NSIndexPath *)indexPath shouldPushTo:(__kindof BaseViewController *)targetVC {
    BaseTableModelRow *model = [self rowModel:indexPath];
    if ([model.cmd containsString:@"apple.com"]) {
        [NSBlockOperation ax_delay:0.5 performInBackground:^{
            [[UIApplication sharedApplication] openURL:model.cmd.absoluteURL options:@{} completionHandler:^(BOOL success) {
                
            }];
        }];
        return NO;
    } else {
        ProjectDetailVC *vc = targetVC;
        vc.urlStr = model.cmd;
        return YES;
    }
    
}



@end
