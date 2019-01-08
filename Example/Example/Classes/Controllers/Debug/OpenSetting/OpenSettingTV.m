//
//  OpenSettingTV.m
//  AXKitDemo
//
//  Created by xaoxuu on 30/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "OpenSettingTV.h"

@implementation OpenSettingTV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(nonnull NSIndexPath *)indexPath model:(nonnull AXTableRowModelType *)model{
    if ([model.cmd isEqualToString:@"app"]) {
        if (@available(iOS 11.0, *)) {
            // on newer versions
            [UIApplication openAppSetting:nil];
        } else {
            // Fallback on earlier versions
            
        }
    }
    
}

@end
