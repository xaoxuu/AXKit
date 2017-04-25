//
//  C1ViewController.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "C1ViewController.h"
#import "AXKit.h"
@interface C1ViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation C1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.testView ax_eachSubview:[UIButton class] action:^(__kindof UIView * _Nonnull subview) {
        UIButton *btn = subview;
        AXLogOBJ(NSStringFromPercent(btn.titleLabel.text.floatValue));
    }];
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
- (IBAction)push:(UIButton *)sender {
    [self ax_pushViewControllerNamed:@"redV3C" animated:YES completion:^(UIViewController *targetVC) {
        
    }];
}

@end
