//
//  ReleaseLogTV.m
//  AXKit
//
//  Created by xaoxuu on 29/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ReleaseLogTV.h"
#import "BaseWebVC.h"

@implementation ReleaseLogTV

- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
//    [services.git getReleaseLogList:^(GitHubIssueListModel *issues) {
//        NSMutableArray<BaseTableModelSection *> *sections = [NSMutableArray array];
//        // @xaoxuu: first section
//        BaseTableModelSection *sec = [BaseTableModelSection new];
//        BaseTableModelRow *row = [BaseTableModelRow new];
//        GitHubIssueModel *issue = issues.items.firstObject;
//        row.title = issue.title;
//        row.cmd = issue.html_url;
//        [sec.rows addObject:row];
//        sec.header_height = @"44";
//
//        sec.header_title = NSLocalizedString(@"最新版本:", nil);
//        // sec.footer_title = issue.body;
//        [sections addObject:sec];
//        // @xaoxuu: others
//        [issues.items removeFirstObject];
//        BaseTableModelSection *sec2 = [BaseTableModelSection new];
//        sec2.header_height = @"44";
//        sec2.header_title = NSLocalizedString(@"历史版本", nil);
//        for (GitHubIssueModel *issue in issues.items) {
//            BaseTableModelRow *row = [BaseTableModelRow new];
//            row.title = issue.title;
//            row.cmd = issue.html_url;
//            [sec2.rows addObject:row];
//        }
//        [sections addObject:sec2];
//        if (dataSource) {
//            dataSource(sections);
//        }
//    }];
}

- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model{
    BaseWebVC *vc = [BaseWebVC webVCWithTitle:model.title URLString:model.target];
    [self.controller.navigationController pushViewController:vc animated:YES];
}




@end
