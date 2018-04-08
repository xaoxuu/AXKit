//
//  AboutVC.m
//  AXKit
//
//  Created by xaoxuu on 20/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AboutVC.h"
#import "AboutTableView.h"
#import "FullWideButton.h"

@interface AboutVC ()

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (AXTableViewType *)installTableView{
    CGRect frame = self.view.bounds;
    frame.size.height -= kTabBarHeight;
    return [[AboutTableView alloc] initWithFrame:frame];
}

- (CGRect)initContentFrame:(CGRect)frame{
    frame.size.height -= kTopBarHeight;
    return frame;
}


- (void)didTableViewInstalled:(AXTableViewType *)tableView{
    [FullWideButton buttonWithTitle:NSLocalizedString(@"检查更新", nil) action:^(__kindof BaseButton *sender) {
        sender.enabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            sender.enabled = YES;
            [UIAlertController ax_showAlertWithTitle:nil message:NSLocalizedString(@"已经是最新版本", nil) actions:nil];
        });
//        [services.app checkVersionCompletion:^(VersionState state) {
//            [NSBlockOperation ax_delay:0.2 performInMainQueue:^{
//                sender.enabled = YES;
//            }];
//            if (state == VersionStateLatest) {
//                [UIAlertController ax_showAlertWithTitle:nil message:NSLocalizedString(@"已经是最新版本", nil) actions:nil];
//            }
//
//        }];
    }].addToView(self.view).layoutToBottom();
    
    
    
}





@end
