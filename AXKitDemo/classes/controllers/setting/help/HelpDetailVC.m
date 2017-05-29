//
//  HelpDetailVC.m
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HelpDetailVC.h"

static CGFloat header = 86;
static CGFloat footer = 60;

@interface HelpDetailVC ()



@end

@implementation HelpDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}
#warning 123
- (void)initContentView:(UIView *)view{
    view.top -= header;
    view.height += header + footer;
}

- (void)initWebView:(WKWebView *)webView{
    webView.scrollView.bounces = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
