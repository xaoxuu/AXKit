//
//  TestFrameVC.m
//  AXKit
//
//  Created by xaoxuu on 02/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "TestFrameVC.h"

@interface TestFrameVC ()

@end

@implementation TestFrameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.top -= 80;
    self.view.width = 300;
    
    
    self.view.backgroundColor = [UIColor md_lime];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
