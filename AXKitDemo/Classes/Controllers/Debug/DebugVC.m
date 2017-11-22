//
//  DebugVC.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DebugVC.h"
#import "DebugTV.h"

@interface DebugVC ()



@end

@implementation DebugVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutSubviews];
}

- (CGRect)initContentFrame:(CGRect)frame{
    frame.origin.y = kTopBarHeight();
    frame.size.height = kScreenH - kTopBarHeight() - kTabBarHeight();
    return frame;
}



- (AXTableViewType *)installTableView{
    CGRect frame = self.view.bounds;
//    frame.size.height += kTopBarHeight();
    return [[DebugTV alloc] initWithFrame:frame];
}



@end
