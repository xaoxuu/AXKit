//
//  AXProgressHUD.h
//  AXKit
//
//  Created by xaoxuu on 10/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


#define axMarkSelfView [ATProgressHUD at_target:self.view showInfo:@"抱歉，此功能尚未开发！" duration:1]
#define axMarkSelf [ATProgressHUD at_target:self showInfo:@"抱歉，此功能尚未开发！" duration:1]



@interface AXProgressHUD : UIView


- (void)ax_showInfo:(NSString *)info duration:(NSTimeInterval)duration;

+ (void)ax_target:(UIView *)target showInfo:(NSString *)info duration:(NSTimeInterval)duration;

+ (void)ax_target:(UIView *)target point:(CGPoint)point showInfo:(NSString *)info duration:(NSTimeInterval)duration;


@end
