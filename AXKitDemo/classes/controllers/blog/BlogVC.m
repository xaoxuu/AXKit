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
    self.urlStr = services.app.blogURL;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self setupTopBar];
    
//    [self.tabBarController.tabBar ax_addDoubleTapGesture:nil duration:1 handler:^(UITapGestureRecognizer * _Nonnull sender) {
//        [self reloadWeb];
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didLoadWebView{
    
}

@end
