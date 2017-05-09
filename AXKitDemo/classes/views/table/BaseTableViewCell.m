//
//  BaseTableViewCell.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DefaultViewController.h"

@interface BaseTableViewCell ()




@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_detail;
@property (weak, nonatomic) IBOutlet UILabel *lb_title_only;


@end

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _sw = [BaseSwitch new];
//    self.img_icon.layer.cornerRadius = 5;
    self.img_icon.layer.ax_maskToCircle();
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BaseTableModel *)model{
    _model = model;
    if (model.icon.length) {
        self.lb_title_only.text = @"";
        self.lb_title.text = NSLocalizedString(model.title, nil);
    } else {
        self.lb_title_only.text = NSLocalizedString(model.title, nil);
        self.lb_title.text = @"";
    }
    
    // @xaoxuu: 数据显示
    self.lb_detail.text = NSLocalizedString(model.desc, nil);
    // @xaoxuu: 图片
    if (model.icon.isURLString) {
        // @xaoxuu: 网络图片
        [self.img_icon setImageWithURL:model.icon.absoluteURL placeholder:services.app.placeholderForSetting];
    } else {
        // @xaoxuu: 本地图片
        self.img_icon.image = model.icon.image;
    }
    

}


- (void)setIcon:(UIImage *)icon{
    _icon = icon;
    self.img_icon.image = icon;
    if (self.lb_title_only.text.length) {
        self.lb_title.text = self.lb_title_only.text;
        self.lb_title_only.text = @"";
    }
}


@end
