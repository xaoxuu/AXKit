//
//  DebugTV.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DebugTV.h"
#import <AXCameraKit/AXCameraKit.h>

@implementation DebugTV

- (void)ax_tableViewDidSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    AXTableRowModelType *model = [self tableViewRowModelForIndexPath:indexPath];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 7) {
            [NSUserDefaults ax_readStringForKey:@"123" completion:^(NSString * _Nonnull string) {
                AXLogSuccess();
            } failure:^(NSError * _Nonnull error) {
                AXLogFailure();
            }];
        } else if (row == 8) {
            AXCameraViewController *vc = [[AXCameraViewController alloc] init];
            [self.controller presentViewController:vc animated:YES completion:^{
                
            }];
        } else {
            [self.controller.navigationController ax_pushViewControllerNamed:model.target];
        }
    } else {
        [self.controller.navigationController ax_pushViewControllerNamed:model.target];
    }
}


- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    tableView.tableFooterView = UIViewWithHeight(44);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}



@end
