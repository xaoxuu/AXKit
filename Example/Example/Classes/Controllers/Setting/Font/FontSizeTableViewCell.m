//
//  FontTableViewCell.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FontSizeTableViewCell.h"

@interface FontSizeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *value;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UITextView *preview;

@end



@implementation FontSizeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self updateUI];
    
    __weak typeof(self) weakSelf = self;
    [self.slider ax_addValueChangedHandler:^(__kindof UISlider * _Nonnull sender) {
        CGFloat size = [NSString stringWithFormat:@"%.1f", sender.value].doubleValue;
        [axThemeManager updateCurrentFontTheme:^(UIThemeFontModel *font) {
            font.prefersFontSize = size;
        }];
        [weakSelf updateUI];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateUI{
    self.preview.font = axThemeManager.font.customNormal;
    self.slider.value = axThemeManager.font.prefersFontSize;
    self.value.text = [NSString stringWithFormat:@"%.1f", self.slider.value];
}


@end
