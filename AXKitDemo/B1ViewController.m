//
//  B1ViewController.m
//  AXKit
//
//  Created by xaoxuu on 19/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "B1ViewController.h"
#import <AXKit/AXKit.h>
@interface B1ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *input;

@end

@implementation B1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
