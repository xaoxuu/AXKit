//
//  DebugVC.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DebugVC.h"
#import "DebugTV.h"

@interface DebugVC ()



@end

@implementation DebugVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"AXKit";
    if (@available(iOS 11.0, *)) {
        // on newer versions
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    } else {
        // Fallback on earlier versions
        
    }
    
    NSString *languageCode = [NSLocale currentLocale].languageCode;
    NSString *urlString = @"https://xaoxuu.com/docs/axkit";
    if ([languageCode isEqualToString:@"zh"]) {
        urlString = [urlString stringByAppendingString:@"/#/zh-cn/"];
    }
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithImageName:@"icon_help" action:^(UIBarButtonItem * _Nonnull sender) {
        [UIApplication ax_presentSafariViewControllerWithURL:[NSURL URLWithString:urlString] fromViewController:weakSelf];
    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutSubviews];
}

//- (CGRect)initContentFrame:(CGRect)frame{
//    frame.origin.y = kTopBarHeight;
//    frame.size.height = kScreenH - kTopBarHeight - kTabBarHeight;
//    return frame;
//}



- (AXTableViewType *)installTableView{
    CGRect frame = self.view.bounds;
//    frame.size.height += kTopBarHeight();
    return [[DebugTV alloc] initWithFrame:frame];
}



@end
