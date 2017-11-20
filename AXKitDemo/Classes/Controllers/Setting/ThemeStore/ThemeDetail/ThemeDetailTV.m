//
//  ThemeDetailTV.m
//  AXKitDemo
//
//  Created by xaoxuu on 20/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeDetailTV.h"
#import "ThemePreviewView.h"
#import "FeedbackKit.h"

@interface ThemeDetailTV ()

@property (strong, nonatomic) ThemePreviewView *header;

@end

@implementation ThemeDetailTV

- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    self.header = UIViewFromNibNamed(@"ThemePreviewView");
    self.header.model = self.theme;
    tableView.tableHeaderView = self.header;
}

- (void)ax_tableViewDataSource:(void (^)(AXTableModelType *))dataSource{
    AXTableModel *model = [AXTableModel new];
    [model addSection:^(AXTableSectionModel *section) {
        section.headerTitle = @"主题信息";
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"主题";
            row.detail = self.model.name;
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"主题色";
            row.detail = self.theme.color.theme.hexStringWithAlpha;
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"字体";
            row.detail = self.theme.font.name;
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"字号";
            row.detail = NSStringFromCGFloat(self.theme.font.prefersFontSize);
        }];
        
    }];
    [model addSection:^(AXTableSectionModel *section) {
        section.headerTitle = @"作者信息";
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"作者";
            row.detail = self.model.author;
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"邮箱";
            row.detail = self.model.email;
        }];
        
    }];
    dataSource(model);
}

- (void)updateWithTheme:(UIThemeModel *)theme{
    self.header.model = theme;
    self.theme = theme;
}

- (void)ax_tableViewDidSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    AXTableRowModelType *model = [self tableViewRowModelForIndexPath:indexPath];
    if ([model.title isEqualToString:@"邮箱"]) {
        [self.controller sendEmail:^(MFMailComposeViewController *mailCompose) {
            // 设置收件人
            [mailCompose setToRecipients:@[model.detail]];
        } completion:^(MFMailComposeResult result) {
            
        } fail:^(NSError *error) {
            [UIAlertController ax_showAlertWithTitle:@"无法发送邮件" message:nil actions:nil];
        }];
    }
}

@end
