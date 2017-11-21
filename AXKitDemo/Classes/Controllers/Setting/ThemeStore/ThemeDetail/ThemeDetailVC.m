//
//  ThemeDetailVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeDetailVC.h"
#import "ThemeDetailTV.h"


@interface ThemeDetailVC ()

@property (strong, nonatomic) ThemeDetailTV *tableView;

@end

@implementation ThemeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.model.name;
    
    NSString *btnTitle = @"下载";
    self.tableView.model = self.model;
    if ([service.cache isThemeDownloaded:self.model]) {
        btnTitle = @"应用";
        [self.tableView updateWithTheme:[UIThemeModel modelWithEmail:self.model.email name:self.model.name]];
    }
    [self.tableView reloadDataSourceAndRefreshTableView];
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithTitle:btnTitle action:^(UIBarButtonItem * _Nonnull sender) {
        if ([sender.title isEqualToString:@"下载"]) {
            [service.cache downloadTheme:weakSelf.model completion:^(UIThemeModel *theme) {
                AXLogOBJ(theme);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // @xaoxuu: in main queue
                    sender.title = @"应用";
                    [weakSelf.tableView updateWithTheme:theme];
                });
            }];
        } else {
            // 应用主题
            if ([service.cache isThemeDownloaded:weakSelf.model]) {
                [axThemeManager applyThemeWithEmail:weakSelf.model.email name:weakSelf.model.name];
            }
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (AXTableViewType *)installTableView{
    CGRect frame = self.view.bounds;
    self.tableView = [[ThemeDetailTV alloc] initWithFrame:frame];
    return self.tableView;
}




@end
