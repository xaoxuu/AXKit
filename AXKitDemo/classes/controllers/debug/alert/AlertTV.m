//
//  AlertTV.m
//  AXKit
//
//  Created by xaoxuu on 13/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AlertTV.h"

@implementation AlertTV


- (void)indexPath:(NSIndexPath *)indexPath cell:(UITableViewCell<BaseTableViewCell> *)cell willSetModel:(BaseTableModelRow *)model{
    
}


- (void)indexPath:(NSIndexPath *)indexPath didSelected:(__kindof BaseTableModelRow *)model{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            [UIAlertController ax_showAlertWithTitle:model.title message:nil action:nil];
        } else if (row == 1) {
            [UIAlertController ax_showAlertWithTitle:model.title message:nil ok:^(UIAlertAction * _Nonnull sender) {
                AXLogOBJ(sender);
            }];
        } else if (row == 2) {
            [UIAlertController ax_showAlertWithTitle:model.title message:nil action:^(UIAlertController * _Nonnull alert) {
                [alert ax_addCancelActionWithTitle:@"取消按钮" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
                [alert ax_addDefaultActionWithTitle:@"确定按钮" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
            }];
        } else if (row == 3) {
            [UIAlertController ax_showAlertWithTitle:model.title message:nil action:^(UIAlertController * _Nonnull alert) {
                [alert ax_addCancelActionWithTitle:@"取消按钮" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
                [alert ax_addDefaultActionWithTitle:@"确定按钮" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
                [alert ax_addDestructiveActionWithTitle:@"删除" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
            }];
        } else if (row == 4) {
            [UIAlertController ax_showAlertWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n\n" action:^(UIAlertController * _Nonnull alert) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 8, kAlertWidth-16, 222.3-16)];
                view.backgroundColor = [UIColor md_yellow];
                view.layer.masksToBounds = YES;
                view.layer.cornerRadius = 8;
                
                UIActivityIndicatorView *indicator = [UIActivityIndicatorView defaultIndicatorWithLoading];
                [indicator addToView:view withLoading:YES];
                [alert.view addSubview:view];
                
            }];

        }
    } else if (section == 1) {
        if (row == 0) {
            [UIAlertController ax_showActionSheetWithTitle:model.title message:nil action:nil];
        } else if (row == 1) {
            [UIAlertController ax_showActionSheetWithTitle:model.title message:nil ok:^(UIAlertAction * _Nonnull sender) {
                AXLogOBJ(sender);
            }];
        } else if (row == 2) {
            [UIAlertController ax_showActionSheetWithTitle:model.title message:nil action:^(UIAlertController * _Nonnull alert) {
                [alert ax_addCancelActionWithTitle:@"取消按钮" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
                [alert ax_addDefaultActionWithTitle:@"确定按钮" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
            }];
        } else if (row == 3) {
            [UIAlertController ax_showActionSheetWithTitle:model.title message:nil action:^(UIAlertController * _Nonnull alert) {
                [alert ax_addCancelActionWithTitle:@"取消按钮" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
                [alert ax_addDefaultActionWithTitle:@"确定按钮" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
                [alert ax_addDestructiveActionWithTitle:@"删除" handler:^(UIAlertAction * _Nonnull sender) {
                    AXLogOBJ(sender);
                }];
            }];
        } else if (row == 4) {
            [UIAlertController ax_showActionSheetWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n\n" action:^(UIAlertController * _Nonnull alert) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 8, kActionSheetWidth-16, 242-16)];
                view.backgroundColor = [UIColor md_yellow];
                view.layer.masksToBounds = YES;
                view.layer.cornerRadius = 8;
                
                UIActivityIndicatorView *indicator = [UIActivityIndicatorView defaultIndicatorWithLoading];
                [indicator addToView:view withLoading:YES];
                [alert.view addSubview:view];
                
            }];
            
        }
    }
}

@end
