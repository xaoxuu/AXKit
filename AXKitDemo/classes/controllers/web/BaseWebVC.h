//
//  BaseWebVC.h
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebVC : BaseViewController


// @xaoxuu: url string
@property (copy, nonatomic) NSString *urlStr;

+ (instancetype)webVCWithURLString:(NSString *)url;

+ (instancetype)webVCWithTitle:(NSString *)title URLString:(NSString *)url;

- (void)reloadWeb;

@end
