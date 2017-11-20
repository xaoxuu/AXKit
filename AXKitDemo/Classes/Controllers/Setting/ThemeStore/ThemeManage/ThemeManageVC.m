//
//  ThemeManageVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeManageVC.h"

@interface ThemeManageVC ()

@property (strong, nonatomic) ThemeCollectionModel *dataList;

@end

@implementation ThemeManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"主题管理";
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (ThemeCollectionModel *)dataList{
    if (!_dataList.sections) {
        _dataList = [ThemeCollectionModel new];
        [_dataList addSection:^(ThemeCollectionSectionModel *section) {
            section.title = @"已下载的主题";
            NSArray<UIThemeModel *> *themes = [UIThemeManager getAllDownloadedThemes];
            [themes enumerateObjectsUsingBlock:^(UIThemeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [section addRow:^(ThemeCollectionRowModel *row) {
                    row.name = obj.name;
                    row.email = obj.email;
                    row.author = obj.author;
                }];
            }];
        }];
    }
    return _dataList;
}



@end
