//
//  ThemeCollectionViewCell.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ThemeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgv;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *fee;

@end

@implementation ThemeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgv.backgroundColor = [UIColor randomColor];
}

- (void)setModel:(AXThemeModel *)model{
    _model = model;
    
    self.title.font = axThemeManager.font.customNormal;
    self.title.text = model.info.name;
    if (model.info.price <= 0) {
        self.fee.text = @"免费";
    } else {
        self.fee.text = [NSString stringWithFormat:@"￥%.2f", model.info.price];
    }
    
    if (model.info.preview.count) {
        [self.imgv sd_setImageWithURL:[NSURL URLWithString:model.info.preview.firstObject]];
    }
    
}

- (void)dealloc{
    AXLogSuccess();
}

@end
