//
//  CameraView.h
//  Link
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraView : UIView

// @xaoxuu: theme color
@property (strong, nonatomic) UIColor *themeColor;

@property (weak, nonatomic) IBOutlet UIView *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIView *swapButton;

@end
