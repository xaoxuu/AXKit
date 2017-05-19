//
//  BlogListTableView.m
//  AXKit
//
//  Created by xaoxuu on 19/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BlogListTableView.h"
#import "BaseWebVC.h"

@implementation BlogListTableView


- (void)setupTableViewDataSource:(void (^)(BaseTableModelListType))dataSource{
    [services.git getBlogList:^(NSArray<BlogListModel *> *blogs) {
        BaseTableModelSection *sec = [BaseTableModelSection new];
        for (BlogListModel *blog in blogs) {
            BaseTableModelRow *row = [BaseTableModelRow new];
            row.title = blog.name;
            row.cmd = blog.html_url;
            [sec.rows addObject:row];
        }
        sec.header_title = @"test blog";
        dataSource([NSMutableArray arrayWithArray:@[sec]]);
    }];
}

- (BOOL)tableViewCellShouldPushToViewController:(__kindof BaseViewController *)targetVC withModel:(__kindof BaseTableModelRow *)model section:(NSUInteger)section row:(NSUInteger)row{
    BaseWebVC *vc = [BaseWebVC webVCWithURLString:model.cmd];
    [self.controller.navigationController pushViewController:vc animated:YES];
    return NO;
}

@end
