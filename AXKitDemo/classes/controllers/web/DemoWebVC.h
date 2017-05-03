//
//  DemoWebVC.h
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseViewController.h"

@interface DemoWebVC : BaseViewController


// @xaoxuu: url string
@property (copy, nonatomic) NSString *urlStr;

+ (instancetype)webVCWithTitle:(NSString *)title URL:(NSString *)url;

- (void)reloadWeb;

@end
