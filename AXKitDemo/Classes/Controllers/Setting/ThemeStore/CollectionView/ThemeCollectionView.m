//
//  ThemeCollectionView.m
//  AXKitDemo
//
//  Created by xaoxuu on 20/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeCollectionView.h"

#import "ThemeCollectionViewCell.h"
#import "ThemeCollectionReusableView.h"
#import "ThemeDetailVC.h"
#import "MJRefresh.h"

static NSString *headerReuseIdentifier = @"ThemeCollectionReusableView";
static NSString *reuseIdentifier = @"ThemeCollectionViewCell";

@interface ThemeCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) ThemeCollectionModel *dataList;


@end
@implementation ThemeCollectionView


- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupCollectionView];
}

- (void)setupCollectionView{
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:reuseIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    [self registerNib:[UINib nibWithNibName:headerReuseIdentifier bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
//    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.contentInset = UIEdgeInsetsMake(0, 4, 0, 4);
    self.backgroundColor = [UIColor clearColor];
    
    self.width = kScreenW;
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(self.width, 64);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    CGFloat width = (self.width-8)/3;
    flowLayout.itemSize = CGSizeMake(width, width * 4 / 3 + 50);
    flowLayout.sectionInset = UIEdgeInsetsZero;
    self.collectionViewLayout = flowLayout;
    
    [self loadDataFromNetwork];
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromNetwork)];
}

- (ThemeCollectionModel *)dataList{
    if (!_dataList) {
        _dataList = [service.cache cachedThemeList];
    }
    return _dataList;
}

- (void)loadDataFromNetwork{
    [service.cache loadThemeList:^(ThemeCollectionModel *model) {
        self.dataList = model;
        dispatch_async(dispatch_get_main_queue(), ^{
            // @xaoxuu: in main queue
            [self reloadData];
            [self.mj_header endRefreshing];
        });
    }];
}

- (void)reloadData{
    self.dataList = nil;
    [super reloadData];
}


#pragma mark - data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataList.sections.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.sections[section].themes.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ThemeCollectionViewCell *cell = (ThemeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = self.dataList.sections[indexPath.section].themes[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ThemeCollectionReusableView *header = (ThemeCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
    header.title.text = self.dataList.sections[indexPath.section].title;
    header.title.font = axThemeManager.font.customLarge;
    return header;
}

#pragma mark - delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ThemeDetailVC *vc = [[ThemeDetailVC alloc] init];
    vc.model = self.dataList.sections[indexPath.section].themes[indexPath.row];
    [self.controller.navigationController pushViewController:vc animated:YES];
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(8, 8, 8, 8);
//}

@end
