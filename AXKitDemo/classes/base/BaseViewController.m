//
//  BaseViewController.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectFromScreen();
    self.view.backgroundColor = axColor.background;
    self.navigationItem.backBarButtonItem = [UIBarButtonItem ax_itemWithTitle:NSLocalizedString(@"", nil) action:^(id  _Nonnull sender) {
        
    }];
    
    
    if (!self.title.length) {
        self.title = NSLocalizedString(NSStringFromClass([self class]), nil);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}



- (BOOL)hidesBottomBarWhenPushed{
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    } else {
        return YES;
    }
}


@end
