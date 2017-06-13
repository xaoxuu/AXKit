//
//  KeyboardVC.m
//  AXKit
//
//  Created by xaoxuu on 13/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "KeyboardVC.h"

@interface KeyboardVC ()

@end

@implementation KeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 10; i++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(16, 16+i*80, kScreenW-32, 40)];
        [tf ax_adjustViewFrameWithKeyboard:self.view];
        [self.view addSubview:tf];
        tf.placeholder = NSStringFromInt(i);
        tf.backgroundColor = axColor.lightGray.light;
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


@end
