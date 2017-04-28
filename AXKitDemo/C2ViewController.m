//
//  C2ViewController.m
//  AXKit
//
//  Created by xaoxuu on 27/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "C2ViewController.h"

#import "AXKit.h"


@interface C2ViewController ()
@property (weak, nonatomic) IBOutlet UIView *a1;

@end

@implementation C2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController ax_pushViewControllerNamed:@"tmpVC" animated:YES completion:^(UIViewController * _Nonnull targetVC) {
        targetVC.title = @"tmp";
    } fail:^(NSError * _Nonnull error) {
        AXLogError(error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // @xaoxuu: 建议在项目成型之前使用，避免了频繁更改造成代码混乱，也能够提高开发效率。
    // @xaoxuu: 缺点是略微影响性能，可以在项目成型之后删掉此代码，手动替换。
    AXLocalizedAllSubviewsInView(self.view);
    
}


@end
