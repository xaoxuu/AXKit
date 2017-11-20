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


static NSString *headerReuseIdentifier = @"ThemeCollectionReusableView";
static NSString *reuseIdentifier = @"ThemeCollectionViewCell";

@interface ThemeCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

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
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.contentInset = UIEdgeInsetsMake(0, 4, 0, 4);
    
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc] init];
    
    self.width = kScreenW;
    flowLayout.headerReferenceSize = CGSizeMake(self.width, 64);
    
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    CGFloat width = (self.width-8)/3;
    flowLayout.itemSize = CGSizeMake(width, width * 4 / 3 + 50);
    flowLayout.sectionInset = UIEdgeInsetsZero;
    self.collectionViewLayout = flowLayout;
    [self loadDataFromNetwork];
}

- (ThemeCollectionModel *)dataList{
    if (!_dataList.sections) {
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
        });
    }];
}

- (void)reloadData{
    
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


@end
