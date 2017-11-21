//
//  ThemeStoreVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeStoreVC.h"
//#import "ThemeCollectionModel.h"
//#import "ThemeCollectionViewCell.h"
//#import "ThemeCollectionReusableView.h"
//#import "ThemeDetailVC.h"
#import "ThemeCollectionView.h"

//static NSString *headerReuseIdentifier = @"ThemeCollectionReusableView";
//static NSString *reuseIdentifier = @"ThemeCollectionViewCell";

@interface ThemeStoreVC ()
//<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//@property (weak, nonatomic) IBOutlet UICollectionView *collection;
//
//@property (strong, nonatomic) ThemeCollectionModel *dataList;



@end

@implementation ThemeStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"在线主题";
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithTitle:@"清空缓存" action:^(UIBarButtonItem * _Nonnull sender) {
//        [weakSelf.navigationController ax_pushViewControllerNamed:@"ThemeManageVC"];
        [UIThemeModel deleteAllThemes];
    }];
    
//    [self setupCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupCollectionView{
    
//    self.collection.dataSource = self;
//    self.collection.delegate = self;
//    [self.collection registerNib:[UINib nibWithNibName:reuseIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collection registerNib:[UINib nibWithNibName:headerReuseIdentifier bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
//    self.collection.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.collection.contentInset = UIEdgeInsetsMake(0, 4, 0, 4);
//
//    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc] init];
//
//    flowLayout.headerReferenceSize = CGSizeMake(self.collection.width, 50);
//
//    flowLayout.minimumLineSpacing = 0;
//    flowLayout.minimumInteritemSpacing = 0;
//    CGFloat width = 0.5 * self.view.width - 4;
//    flowLayout.itemSize = CGSizeMake(width, width * 4 / 3 + 50);
//    flowLayout.sectionInset = UIEdgeInsetsZero;
//    self.collection.collectionViewLayout = flowLayout;
}

//- (ThemeCollectionModel *)dataList{
//    if (!_dataList.sections) {
//        _dataList = [service.cache cachedThemeList];
//        [service.cache loadThemeList:^(ThemeCollectionModel *model) {
//            _dataList = model;
//            [self.collection reloadData];
//        }];
//    }
//    return _dataList;
//}




//#pragma mark - data source
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.dataList.sections.count;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.dataList.sections[section].themes.count;
//}
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    ThemeCollectionViewCell *cell = (ThemeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.model = self.dataList.sections[indexPath.section].themes[indexPath.row];
//    return cell;
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    ThemeCollectionReusableView *header = (ThemeCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
//    header.title.text = self.dataList.sections[indexPath.section].title;
//    return header;
//}
//
//#pragma mark - delegate
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    ThemeDetailVC *vc = [[ThemeDetailVC alloc] init];
//    vc.model = self.dataList.sections[indexPath.section].themes[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat width = 0.5 * self.view.width;
//    return CGSizeMake(width, width * 4 / 3 + 50);
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

@end
