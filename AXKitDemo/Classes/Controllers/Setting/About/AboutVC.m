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
    self.title = @"";
    self.view.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (AXTableViewType *)installTableView{
//    CGRect frame = self.view.bounds;
//    frame.size.height -= kTabBarHeight;
//    frame.size.width = kScreenW - 60 - 16;
    return [[AboutTableView alloc] initWithFrame:CGRectMake(8, 0, kScreenW - 60 - 16, kScreenH)];
}

//- (CGRect)initContentFrame:(CGRect)frame{
//    frame.size.height -= kTopBarHeight;
//    return frame;
//}

- (CGRect)initContentFrame:(CGRect)frame{
    return kScreenBounds;
//    frame.origin.y = kTopBarHeight;
//    frame.size.height = kScreenH - kTopBarHeight;
//    frame.size.width = kScreenW - 60 - 16;
//    return frame;
}


- (void)didTableViewInstalled:(AXTableViewType *)tableView{
//    [FullWideButton buttonWithTitle:NSLocalizedString(@"检查更新", nil) action:^(__kindof BaseButton *sender) {
//        sender.enabled = NO;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            sender.enabled = YES;
//            [UIAlertController ax_showAlertWithTitle:nil message:NSLocalizedString(@"已经是最新版本", nil) actions:nil];
//        });
////        [services.app checkVersionCompletion:^(VersionState state) {
////            [NSBlockOperation ax_delay:0.2 performInMainQueue:^{
////                sender.enabled = YES;
////            }];
////            if (state == VersionStateLatest) {
////                [UIAlertController ax_showAlertWithTitle:nil message:NSLocalizedString(@"已经是最新版本", nil) actions:nil];
////            }
////
////        }];
//    }].addToView(self.view).layoutToBottom();
    
    
    
}





@end
