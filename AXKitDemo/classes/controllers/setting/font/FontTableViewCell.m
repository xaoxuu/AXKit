//
//  FontTableViewCell.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FontTableViewCell.h"

@interface FontTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *lb;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *lb_preview;

@end



@implementation FontTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [self updateUIWithFontSize:axFont.prefersFontSize];
    
    __weak typeof(self) weakSelf = self;
    [self.slider ax_addValueChangedHandler:^(__kindof UISlider * _Nonnull sender) {
        CGFloat size = sender.value;
        [weakSelf updateUIWithFontSize:size];
    }];
    [self.slider ax_addTouchUpHandler:^(__kindof UISlider * _Nonnull sender) {
        axFont.prefersFontSize = sender.value;
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateUIWithFontSize:(CGFloat)size{
    self.lb_preview.font = [axFont fontWithCustomPrefersFontSize:size];
    self.lb.text = [NSString stringWithFormat:@"%.1f", size];
    self.slider.value = size;
}


- (void)setModel:(__kindof BaseTableModelRow *)model{
    AXLogFunc();
}

- (void)setIcon:(UIImage *)icon{
    AXLogFunc();
}

@end
