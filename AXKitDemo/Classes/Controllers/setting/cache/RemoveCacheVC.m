//
//  RemoveCacheVC.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "RemoveCacheVC.h"
#import "CacheTableView.h"
#import "FullWideButton.h"

@interface RemoveCacheVC ()

// @xaoxuu: cache table view
@property (strong, nonatomic) CacheTableView *cacheTable;

@end

@implementation RemoveCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    AXLogOBJ(@"".cachePath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView<BaseTableView> *)installTableView{
    return [[CacheTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-kTopBarHeight-kTabBarHeight)];
    
}

- (void)didTableViewInstalled:(UITableView<BaseTableView> *)tableView{
    [FullWideButton buttonWithTitle:NSLocalizedString(@"清除缓存", nil) action:^(__kindof BaseButton *sender) {
        sender.enabled = NO;
        [services.cache removeAllCacheCompletion:^{
            // @xaoxuu: 太快视觉上看不出来
            [NSBlockOperation ax_delay:0.3 performInMainQueue:^{
                sender.enabled = YES;
            }];
            [tableView reloadDataSourceAndTableView];
        }];
    }].addToView(self.view).layoutToBottom();
    
}



@end
