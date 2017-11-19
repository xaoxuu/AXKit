//
//  CameraView.m
//  Link
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CameraView.h"
#import <AXKit/AXKit.h>

@interface CameraView()

@property (weak, nonatomic) IBOutlet UIImageView *img_takePhoto;

@property (weak, nonatomic) IBOutlet UIImageView *img_swap;
@property (weak, nonatomic) IBOutlet UIImageView *img_cancel;



@end

@implementation CameraView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    
//    UIColor *tint = [UIColor colorWithHexString:@"#9AD8DE"];
    UIColor *tint = self.themeColor;
    if (self.themeColor.isLightColor) {
        tint = self.themeColor.darkRatio(0.3);
    }
    self.takePhotoButton.backgroundColor = tint;
    [self.takePhotoButton ax_layer:^(CALayer * _Nonnull layer) {
        [layer ax_maskToCircle];
    }];
    
    self.img_swap.tintColor = tint;
    self.img_cancel.tintColor = tint;
    self.img_takePhoto.tintColor = [UIColor whiteColor];
    
}

@end
