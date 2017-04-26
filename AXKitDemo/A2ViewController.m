//
//  A2ViewController.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "A2ViewController.h"
#import "AXKit.h"

@interface A2ViewController ()

@end

@implementation A2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view ax_eachSubview:[UITextField class] action:^(__kindof UIView * _Nonnull subview) {
        UITextField *tf = subview;
        [tf ax_adjustViewFrameWithKeyboard:tf];
    }];
    [self.view ax_eachSubview:[UITextView class] action:^(__kindof UIView * _Nonnull subview) {
        UITextView *tv = subview;
        [tv ax_adjustViewFrameWithKeyboard:tv];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        [subview resignFirstResponder];
    }];
}

@end
