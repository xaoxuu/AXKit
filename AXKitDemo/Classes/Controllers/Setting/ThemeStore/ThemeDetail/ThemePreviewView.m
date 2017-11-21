//
//  ThemePreviewView.m
//  AXKitDemo
//
//  Created by xaoxuu on 20/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemePreviewView.h"
#import "ThemePreviewCollectionViewCell.h"
#import <UIImageView+WebCache.h>

static NSString *reuseIdentifier = @"ThemePreviewCollectionViewCell";

@interface ThemePreviewView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ThemePreviewView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.height = 360;
    self.width = kScreenW;
    
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = self.frame.size;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.model) {
        return self.model.info.preview.count;
    } else {
        return 0;
    }
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ThemePreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.model.info.preview.count) {
        [cell.imgv sd_setImageWithURL:self.model.info.preview[indexPath.row].absoluteURL];
    }

    return cell;
}


@end
