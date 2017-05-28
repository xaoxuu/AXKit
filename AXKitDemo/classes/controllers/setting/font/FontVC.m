//
//  FontVC.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FontVC.h"
#import "FontTableView.h"

@interface FontVC ()

@end

@implementation FontVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [NSBlockOperation ax_delay:2 performInMainQueue:^{
        [UIAlertController ax_showAlertWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n\n" action:^(UIAlertController * _Nonnull alert) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 8, 270-16, 222.3-16)];
            view.backgroundColor = axColor.theme;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 8;
            
            [alert.view addSubview:view];
            
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UITableView<BaseTableView> *)installTableView{
    return [[FontTableView alloc] initWithFrame:self.view.bounds];
}

@end
