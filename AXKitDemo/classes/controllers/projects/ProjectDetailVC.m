//
//  ProjectDetailVC.m
//  AXKit
//
//  Created by xaoxuu on 12/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ProjectDetailVC.h"

@interface ProjectDetailVC ()

@end

@implementation ProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didLoadWebView{
    if ([self.urlStr containsString:@"apple.com"]) {
        [NSBlockOperation ax_delay:0.5 performInBackground:^{
            [[UIApplication sharedApplication] openURL:self.urlStr.absoluteURL];
        }];
    }
}

@end
