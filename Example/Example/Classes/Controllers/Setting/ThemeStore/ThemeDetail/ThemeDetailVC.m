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
    self.title = @"主题预览";
    
    NSString *btnTitle = @"下载";
    if ([service.cache isThemeDownloaded:self.model]) {
        btnTitle = @"应用";
        
    }
    [self.tableView updateWithTheme:self.model];
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithTitle:btnTitle action:^(UIBarButtonItem * _Nonnull sender) {
        if ([sender.title isEqualToString:@"下载"]) {
            [service.cache downloadTheme:weakSelf.model completion:^(AXThemeModel *theme) {
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
                [axThemeManager applyTheme:weakSelf.model];
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
