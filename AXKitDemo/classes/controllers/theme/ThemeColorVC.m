//
//  ThemeColorVC.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeColorVC.h"
#import "ThemeColorTableView.h"

@interface ThemeColorVC ()

// @xaoxuu: table view
@property (strong, nonatomic) ThemeColorTableView *table;

@end

@implementation ThemeColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"主题色", nil);
    
    [self setupTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTable{
    self.table = [[ThemeColorTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-kTopBarHeight)];
    [self.view addSubview:self.table];
}


@end
