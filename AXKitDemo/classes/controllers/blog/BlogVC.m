//
//  BlogVC.m
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BlogVC.h"

@interface BlogVC ()

@end

@implementation BlogVC

- (void)viewDidLoad {
    self.urlStr = kURL_BLOG;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTopBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTopBar{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithSystem:UIBarButtonSystemItemRefresh action:^(id  _Nonnull sender) {
        [self reloadWeb];
    }];
}

@end
