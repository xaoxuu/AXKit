//
//  CustomTableVC.h
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseViewController.h"

@interface CustomTableVC : BaseViewController

// @xaoxuu: detail
@property (copy, nonatomic) NSString *detail;

// @xaoxuu: cmd
@property (copy, nonatomic) NSString *cmd;

+ (instancetype)defaultVCWithTitle:(NSString *)title detail:(NSString *)detail;


@end
