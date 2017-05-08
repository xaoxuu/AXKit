//
//  DefaultViewController.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DefaultViewController.h"

@interface DefaultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_detail;

@end

@implementation DefaultViewController

+ (instancetype)defaultVCWithTitle:(NSString *)title detail:(NSString *)detail{
    return [[self alloc] initWithTitle:title detail:detail];
}

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail{
    if (self = [super init]) {
        self.title = title;
        self.detail = detail;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.lb_title.text = self.title;
    self.lb_detail.text = self.detail;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
