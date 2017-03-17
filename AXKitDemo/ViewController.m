//
//  ViewController.m
//  AXKitDemo
//
//  Created by ayan on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ViewController.h"
#import <AXKit/AXKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *themeview;
@property (weak, nonatomic) IBOutlet UIView *accentview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AXLogOBJ(self);
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.view.backgroundColor = axColor.background;
    self.themeview.backgroundColor = axColor.theme;
    self.accentview.backgroundColor = axColor.accent;
    AXLogFunc;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
