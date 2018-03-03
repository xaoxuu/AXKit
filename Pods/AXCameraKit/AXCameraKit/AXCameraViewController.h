//
//  AXCameraViewController.h
//  AXCameraKit
//
//  Created by xaoxuu on 21/11/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXCameraOverlayView.h"

/**
 自定义相机视图控制器
 */
@interface AXCameraViewController : UIViewController

#pragma mark - 属性
/**
 相机操作按钮覆盖图层
 */
@property (strong, nonatomic) AXCameraOverlayView *overlayView;

#pragma mark - public

/**
 拍照
 */
- (void)takePicture;


/**
 切换前后摄像头
 */
- (void)switchCameraDevice;


/**
 开关闪光灯模式
 0:关, 1:开, 2:自动
 */
- (void)changeFlashMode;




@end
