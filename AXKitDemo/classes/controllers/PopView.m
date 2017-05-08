//
//  PopView.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "PopView.h"

@interface PopView ()



@end

@implementation PopView

- (IBAction)popFromRoot:(UIButton *)sender {
    [self.controller.navigationController ax_popToViewControllerWithIndexFromRoot:sender.titleLabel.text.integerValue animated:YES];
}

- (IBAction)popFromSelf:(UIButton *)sender {
    [self.controller.navigationController ax_popToViewControllerWithIndexFromSelf:sender.titleLabel.text.integerValue animated:YES];
}

@end
