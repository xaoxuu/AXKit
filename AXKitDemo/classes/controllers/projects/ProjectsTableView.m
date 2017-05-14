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

- (BaseTableModelListType)dataListForTableView:(UITableView *)tableView{
    return services.cache.projectList;
}


- (BOOL)tableViewCellShouldPushToViewController:(__kindof BaseViewController *)targetVC withModel:(__kindof BaseTableModelRow *)model{
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
