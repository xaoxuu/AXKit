//
//  DebugTV.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DebugTV.h"
#import "UIViewController+CameraExtension.h"

@implementation DebugTV


- (void)indexPath:(NSIndexPath *)indexPath didSelected:(__kindof BaseTableModelRow *)model{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 8) {
            [NSUserDefaults ax_readStringForKey:@"123" completion:^(NSString * _Nonnull string) {
                AXLogSuccess();
            } failure:^(NSError * _Nonnull error) {
                AXLogFailure();
            }];
        } else if (row == 9) {
            [self.controller showImagePicker];
        } else {
            [self.controller.navigationController ax_pushViewControllerNamed:model.target];
        }
    } else {
        [self.controller.navigationController ax_pushViewControllerNamed:model.target];
    }
}



@end
