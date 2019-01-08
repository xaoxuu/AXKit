//
//  KeyboardVC.m
//  AXKit
//
//  Created by xaoxuu on 13/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "KeyboardVC.h"

@interface KeyboardVC () <UIScrollViewDelegate>

@end

@implementation KeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.delegate = self;
    [self.view addSubview:scroll];
    
    for (int i = 0; i < 20; i++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(kMarginNormal, kMarginNormal+i*80, kScreenW-16, 40)];
        [tf ax_adjustViewFrameWithKeyboard:self.view];
        [scroll addSubview:tf];
        tf.tag = i;
        tf.placeholder = @(i).stringValue;
        tf.backgroundColor = UIColor.lightGrayColor.light;
        tf.returnKeyType = UIReturnKeyNext;
        scroll.contentSize = CGSizeMake(0, tf.bottom + 16);
        
        [tf ax_addEditingEndOnExitHandler:^(__kindof UITextField * _Nonnull sender) {
            UITextField *tf2 = [scroll viewWithTag:sender.tag+1];
            if (tf2) {
                [tf2 becomeFirstResponder];
            }
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
