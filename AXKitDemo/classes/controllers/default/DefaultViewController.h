//
//  DefaultViewController.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseViewController.h"

@interface DefaultViewController : BaseViewController

// @xaoxuu: detail
@property (copy, nonatomic) NSString *detail;


+ (instancetype)defaultVCWithTitle:(NSString *)title detail:(NSString *)detail;


@end
