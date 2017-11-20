//
//  ThemeCollectionViewCell.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeCollectionViewCell.h"
#import <UIImageView+WebCache.h>

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

- (void)setModel:(ThemeCollectionRowModel *)model{
    _model = model;
    
    self.title.font = axThemeManager.font.customNormal;
    self.title.text = model.name;
    if (model.price <= 0) {
        self.fee.text = @"免费";
    } else {
        self.fee.text = [NSString stringWithFormat:@"￥%.2f", model.price];
    }
    [self.imgv sd_setImageWithURL:model.image.absoluteURL];
}

- (void)dealloc{
    AXLogSuccess();
}

@end
