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
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AXLocalizedAllSubviewsInView(self.a1);
    
}


@end
