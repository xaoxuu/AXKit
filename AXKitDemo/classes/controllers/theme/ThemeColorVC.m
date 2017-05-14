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



@end

@implementation ThemeColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"主题色", nil);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (BaseTableView *)setupTableView{
    return [[ThemeColorTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-kTopBarHeight)];
}

@end
