//
//  SettingTableViewCell.m
//  AXKit
//
//  Created by xaoxuu on 17/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "SettingTableViewCell.h"

@interface SettingTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_detail;

// @xaoxuu:
@property (copy, nonatomic) void (^switchStatusChanged)(BOOL on);

@end

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SettingListModel *)model{
    _model = model;
    
    // @xaoxuu: 数据显示
    self.img_icon.image = [UIImage imageNamed:model.icon];
    self.lb_title.text = NSLocalizedString(model.title, nil);
    self.lb_detail.text = NSLocalizedString(model.detail, nil);
    
    // @xaoxuu: 样式
    self.accessoryType = model.showAccessory ? UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    if (model.showSwitch) {
        UISwitch *sw = [[UISwitch alloc] init];
        sw.on = NO;
        self.accessoryView = sw;
        [sw ax_addValueChangedHandler:^(__kindof UISwitch * _Nonnull sender) {
            if (self.switchStatusChanged) {
                self.switchStatusChanged(sender.on);
            }
        }];
        self.sw = sw;
    }
    if (model.showBadge) {
        
    }
    
    // @xaoxuu: 控制器跳转
    UIViewController *vc = [[NSClassFromString(model.target) class] new];
    vc.title = NSLocalizedString(model.title, nil);
    if (vc) {
        [self ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
            [self.controller.navigationController pushViewController:vc animated:YES];
        }];
    }
    
}

- (void)switchStatusChanged:(void (^)(BOOL on))changed{
    self.switchStatusChanged = changed;
}

@end
