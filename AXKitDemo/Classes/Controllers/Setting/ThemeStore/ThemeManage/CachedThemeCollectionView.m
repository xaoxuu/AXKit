//
//  CachedThemeCollectionView.m
//  AXKitDemo
//
//  Created by xaoxuu on 21/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CachedThemeCollectionView.h"
#import "ThemeCollectionModel.h"
#import <MJRefresh/MJRefresh.h>

@interface CachedThemeCollectionView ()


@property (strong, nonatomic) ThemeCollectionModel *dataList;

@end

@implementation CachedThemeCollectionView





- (ThemeCollectionModel *)dataList{
    if (!_dataList) {
        _dataList = [ThemeCollectionModel new];
        NSArray<UIThemeModel *> *themes = [UIThemeManager getAllDownloadedThemes];
        if (themes.count) {
            [_dataList addSection:^(ThemeCollectionSectionModel *section) {
                section.title = @"已下载的主题";
                [themes enumerateObjectsUsingBlock:^(UIThemeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [section.themes addObject:obj];
                }];
            }];
        }
    }
    return _dataList;
}


- (void)loadDataFromNetwork{
    [self.mj_header endRefreshing];
}


@end
