//
//  ThemeDetailTV.m
//  AXKitDemo
//
//  Created by xaoxuu on 20/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeDetailTV.h"
#import "ThemePreviewView.h"
#import "AXFeedbackKit.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ThemeDetailTV ()

@property (strong, nonatomic) ThemePreviewView *header;

@end

@implementation ThemeDetailTV

- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    self.header = UIView.initWithNibName(@"ThemePreviewView");
    self.header.model = self.theme;
    tableView.tableHeaderView = self.header;
}

- (void)ax_tableView:(AXTableViewType *)tableView dataSource:(void (^)(AXTableModelType *))dataSource{
    AXTableModel *model = [AXTableModel new];
    [model addSection:^(AXTableSectionModel *section) {
        
        section.headerTitle = @"主题信息";
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"主题";
            row.detail = self.theme.info.name;
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
            row.detail = @(self.theme.font.prefersFontSize).stringValue;
        }];
        
    }];
    [model addSection:^(AXTableSectionModel *section) {
        section.headerTitle = @"作者信息";
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"作者";
            row.detail = self.theme.info.author;
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"邮箱";
            row.detail = self.theme.info.email;
        }];
        
    }];
    dataSource(model);
}

- (void)updateWithTheme:(AXThemeModel *)theme{
    if (theme) {
        self.theme = theme;
        [self reloadDataSourceAndRefreshTableView];
    }
}

- (void)reloadDataSourceAndRefreshTableView{
    self.header.model = self.theme;
    if (self.theme.color.theme) {
        self.backgroundColor = [self.theme.color.theme lighten:0.7];
    }
    [super reloadDataSourceAndRefreshTableView];
}

- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModel *)model{
    if ([model.title isEqualToString:@"邮箱"]) {
        [[EmailManager sharedInstance] sendEmail:^(MFMailComposeViewController *mailCompose) {
            // 设置收件人
            [mailCompose setToRecipients:@[model.detail]];
        } completion:^(MFMailComposeResult result) {
            
        } fail:^(NSError *error) {
            [UIAlertController ax_showAlertWithTitle:@"无法发送邮件" message:nil actions:nil];
        }];
    }
}

- (void)ax_tableView:(AXTableViewType *)tableView didSetModelForCell:(AXTableViewCellType *)cell atIndexPath:(NSIndexPath *)indexPath{
    if (self.theme.color.theme) {
        cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.85*0.7];;
    }
}


@end
