//
//  FontVC.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FontVC.h"
#import "FontTableView.h"

static ax_dispatch_operation_t token;

@interface FontVC ()

@end

@implementation FontVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    token = [NSBlockOperation ax_delay:2 performInMainQueue:^{
        if (self) {
            [UIAlertController ax_showAlertWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n\n" actions:^(UIAlertController * _Nonnull alert) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 8, 270-16, 222.3-16)];
                view.backgroundColor = axColor.theme;
                view.layer.masksToBounds = YES;
                view.layer.cornerRadius = 8;
                
                [alert.view addSubview:view];
                UIActivityIndicatorView *indicator = [UIActivityIndicatorView defaultIndicatorWithLoading];
                [indicator addToView:view withLoading:YES];
            }];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [NSBlockOperation ax_cancelOperation:token];
    token = nil;
}


- (UITableView<BaseTableView> *)installTableView{
    return [[FontTableView alloc] initWithFrame:self.view.bounds];
}

@end
