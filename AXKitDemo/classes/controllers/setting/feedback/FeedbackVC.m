//
//  FeedbackVC.m
//  AXKit
//
//  Created by xaoxuu on 08/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    self.urlStr = services.app.feedbackURL;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)didLoadWebView{
    if ([self.urlStr containsString:services.app.feedbackEmail]) {
        [[UIApplication sharedApplication] openURL:self.urlStr.absoluteURL];
    }
}

@end
