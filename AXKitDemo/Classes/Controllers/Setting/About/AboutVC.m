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
#import <UIImage+GIF.h>

static UIImage *cachedImage;

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
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    bg.maskView = UIMaskViewWithSizeAndCornerRadius(self.view.bounds.size, 0);
    [self.view insertSubview:bg belowSubview:tableView];
    if (cachedImage) {
        bg.image = cachedImage;
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"header" ofType:@"gif"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            cachedImage = [UIImage sd_animatedGIFWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                bg.image = cachedImage;
            });
        });
    }
    
}





@end
