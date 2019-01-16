//
//  LocalNotificationTV.m
//  AXKitDemo
//
//  Created by xaoxuu on 29/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "LocalNotificationTV.h"
#import "LocalNotificationManager.h"

@implementation LocalNotificationTV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)ax_tableViewDidLoadFinished:(AXTableViewType *)tableView{
    tableView.tableFooterView = [[UIView alloc] initWithHeight:20];
}

- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model{
    if (indexPath.section == 0) {
        NSTimeInterval timeInterval = model.detail.doubleValue;
        [LocalNotificationManager pushNotificationWithTimeInterval:timeInterval message:model.title];
        
    } else if (indexPath.section == 1) {
        NSArray<NSString *> *com = [model.detail componentsSeparatedByString:@":"];
        [LocalNotificationManager pushNotificationWithDateComponents:^(NSDateComponents *components) {
            components.hour = com[0].integerValue;
            components.minute = com[1].integerValue;
        } message:model.title];
    }
    
}



@end
