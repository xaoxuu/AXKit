//
//  B1ViewController.m
//  AXKit
//
//  Created by xaoxuu on 19/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "B1ViewController.h"
#import "AXKit/AXKit.h"
@interface B1ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *input;

@property (weak, nonatomic) IBOutlet UIView *local;


@end

@implementation B1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.local ax_eachSubview:[UILabel class] action:^(__kindof UIView * _Nonnull subview) {
        UILabel *lb = subview;
        AXLocalizedLabel(lb);
    }];
    [self.local ax_eachSubview:[UITextField class] action:^(__kindof UIView * _Nonnull subview) {
        UITextField *tf = subview;
        AXLocalizedTextField(tf);
    }];
    [self.local ax_eachSubview:[UITextView class] action:^(__kindof UIView * _Nonnull subview) {
        UITextView *tv = subview;
        AXLocalizedTextView(tv);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)input:(UITextField *)sender {
    CGFloat o = sender.text.floatValue;
    
    CGFloat g = AXFloatInRange(o, AXFloatRangeMake(0, 1));
    AXLogCGFloat(g);
}
- (IBAction)push:(UIButton *)sender {
    [self.navigationController ax_pushViewControllerNamed:@"redVC2" animated:YES];
}

@end
