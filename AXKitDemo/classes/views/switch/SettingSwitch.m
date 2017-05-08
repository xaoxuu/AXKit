//
//  SettingSwitch.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "SettingSwitch.h"

@implementation SettingSwitch


- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    [self setOnTintColor:axColor.theme];
    [self setOffImage:[UIImage imageNamed:@"watch_close"]];
    [self setOnImage:[UIImage imageNamed:@"watch_open"]];
    
}



@end
