//
//  HelpTableView.m
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HelpTableView.h"
#import "HelpDetailVC.h"
#import "BaseWebVC.h"

@interface HelpTableView () <UISearchBarDelegate, UIScrollViewDelegate>

// @xaoxuu: search bar
@property (strong, nonatomic) UISearchBar *searchBar;

// @xaoxuu: results
@property (strong, nonatomic) BaseTableModelListType source;

// @xaoxuu: results
@property (strong, nonatomic) BaseTableModelListType results;

// @xaoxuu: keyword
@property (copy, nonatomic) NSString *keyword;

@end


@implementation HelpTableView




- (void)setupTableViewWithDataSource:(void (^)(BaseTableModelListType))completion{
    [services.git getHelpIssuesList:^(GitHubIssueListModel *issues) {
        
        BaseTableModelSection *sec = [BaseTableModelSection new];
        sec.header_height = NSStringFromCGFloat(kMarginNormal);
        for (GitHubIssueModel *issue in issues.items) {
            BaseTableModelRow *row = [BaseTableModelRow new];
            row.title = issue.title;
            row.cmd = issue.html_url;
            [sec.rows addObject:row];
        }
        self.source = [NSMutableArray arrayWithArray:@[sec]];
        if (completion) {
            completion(self.source);
        }
    }];
}

- (void)setupTableViewHeader:(UIView *)header{
    [header addSubview:self.searchBar];
    header.height = self.searchBar.height;
}


-(void)tableViewCellDidSelected:(__kindof BaseTableModelRow *)model{
    BaseWebVC *vc = [BaseWebVC webVCWithTitle:model.title URLString:model.cmd];
    [self.controller.navigationController pushViewController:vc animated:YES];
}


- (BOOL)tableViewCellShouldPushToViewController:(__kindof BaseViewController *)targetVC withModel:(__kindof BaseTableModelRow *)model{
    
    
    return NO;
}




- (UISearchBar *)searchBar{
    if (!_searchBar) {
        // create it
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 4, kScreenW, kNavBarHeight)];
        _searchBar.delegate = self;
        // style
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        if (axColor.theme.isLightColor) {
            _searchBar.tintColor = axColor.theme.dark;
            _searchBar.barTintColor = axColor.theme.dark;
        } else {
            _searchBar.tintColor = axColor.theme;
            _searchBar.barTintColor = axColor.theme;
        }
        
        _searchBar.placeholder = @"请输入关键词";
        // do something...
        
    }
    return _searchBar;
}





#pragma mark - search bar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for (id cc in [searchBar subviews]) {
        for (UIView *view in [cc subviews]) {
            if ([NSStringFromClass(view.class)                 isEqualToString:@"UINavigationButton"]) {
                UIButton *btn = (UIButton *)view;
                [btn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
            }
        }
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.text = nil;
    self.keyword = @"";
    [self searchBarEndEditing];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchBarEndEditing];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.keyword = searchText;
    [self searchWithKeyword];
}


- (void)searchWithKeyword{
    
    if (!self.keyword.length) {
        [self reloadTableViewWithDataSource:self.source];
    } else {
        [services.git queryHelpIssuesListWithKeyword:self.keyword completion:^(GitHubIssueListModel *issues) {
            BaseTableModelSection *sec = [BaseTableModelSection new];
            sec.header_height = NSStringFromCGFloat(kMarginNormal);
            for (GitHubIssueModel *issue in issues.items) {
                BaseTableModelRow *row = [BaseTableModelRow new];
                row.title = issue.title;
                row.cmd = issue.html_url;
                [sec.rows addObject:row];
            }
            
            self.results = [NSMutableArray arrayWithArray:@[sec]];
            [self reloadTableViewWithDataSource:self.results];
        }];
    }
}



- (void)searchBarEndEditing{
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
    [self searchWithKeyword];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self searchBarEndEditing];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self searchBarEndEditing];
}

@end
