//
//  TestVC2.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "TestVC2.h"

@interface TestVC2 ()

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:UIViewFromNibNamed(@"PopView")];
    
    [self.view ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self.navigationController ax_pushViewControllerNamed:@"TestVC3"];
        NSArray *arr = [self.navigationController viewControllers];
        
        
        AXLogOBJ(arr);

    }];
    
    [UIAlertController ax_showAlertWithTitle:nil message:nil];
    AXLogOBJ(AXRandomStringFrom(RandomStringTypeName, AXUIntegerRangeMake(2, 20)));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
