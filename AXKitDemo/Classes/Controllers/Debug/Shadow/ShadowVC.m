//
//  ShadowVC.m
//  AXKit
//
//  Created by xaoxuu on 13/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ShadowVC.h"

@interface ShadowVC ()
@property (weak, nonatomic) IBOutlet UIView *v1;

@end

@implementation ShadowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.v1.backgroundColor = axThemeManager.color.theme;
    self.v1.layer.corner(20).shadow(LayerShadowDownFloat);
    
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
