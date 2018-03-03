//
//  AXCameraOverlayView.h
//  AXCameraKit
//
//  Created by xaoxuu on 18/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN



/**
 相机预览层长宽比
 
 - CameraOverlayViewAspectRatio1_1: 1:1
 - CameraOverlayViewAspectRatio4_3: 4:3 (默认值)
 - CameraOverlayViewAspectRatio16_9: 16:9
 - CameraOverlayViewAspectRatioFill: 全屏
 */
typedef NS_ENUM(NSUInteger, CameraOverlayViewAspectRatio) {
    CameraOverlayViewAspectRatio1_1,
    CameraOverlayViewAspectRatio4_3, // default
    CameraOverlayViewAspectRatio16_9,
    CameraOverlayViewAspectRatioFill,
};



/**
 代理
 */
@protocol AXCameraOverlayViewDelegate

@optional

/**
 点击了Dismiss按钮

 @param sender 按钮
 */
- (void)overlayViewDidTappedDismissButton:(UIButton *)sender;

/**
 点击了拍照按钮

 @param sender 按钮
 */
- (void)overlayViewDidTappedShutterButton:(UIButton *)sender;


/**
 改变闪光灯模式

 @param mode 闪光灯模式
 */
- (void)overlayViewDidChangeFlashMode:(AVCaptureFlashMode)mode;


/**
 切换前后摄像头

 @param position 设备位置
 */
- (void)overlayViewDidSwitchCameraDevicePosition:(AVCaptureDevicePosition)position;

/**
 改变长宽比

 @param aspectRatio 长宽比
 */
- (void)overlayViewDidChangeAspectRatio:(CameraOverlayViewAspectRatio)aspectRatio;

/**
 点击了某个点

 @param point 坐标点
 */
- (void)overlayViewDidTouchAtPoint:(CGPoint)point;

@end

/**
 相机的overlay图层
 */
@interface AXCameraOverlayView : UIView


/**
 delegate
 */
@property (weak, nonatomic) NSObject<AXCameraOverlayViewDelegate> *delegate;

#pragma mark - ui
/**
 闪光灯
 */
@property (strong, nonatomic) UIButton *switchFlashlightButton;

/**
 dismiss按钮，用于退出相机页面
 */
@property (strong, nonatomic) UIButton *dismissButton;

/**
 改变长宽比按钮
 */
@property (strong, nonatomic) UIButton *changeAspectRatioButton;

/**
 快门按钮，用于拍照
 */
@property (strong, nonatomic) UIButton *shutterButton;

/**
 切换前后摄像头按钮
 */
@property (strong, nonatomic) UIButton *switchCameraDeviceButton;

/**
 预览照片按钮
 */
@property (strong, nonatomic) UIButton *previewButton;

/**
 设置是否显示缩略图预览，默认为否
 */
@property (assign, getter=isEnablePreview, nonatomic) BOOL enablePreview;


/**
 获取预览层的frame
 */
@property (assign, readonly, nonatomic) CGRect previewFrame;

#pragma mark - state


/**
 闪光灯模式
 */
@property (assign, nonatomic) AVCaptureFlashMode flashMode;


/**
 长宽比
 */
@property (assign, nonatomic) CameraOverlayViewAspectRatio aspectRatio;





/**
 根据屏幕方向更新UI
 */
- (void)updateUIWithDeviceOrientation;


/**
 发送按钮事件

 @param sender 按钮
 */
- (void)sendButtonAction:(UIButton *)sender;


@end
NS_ASSUME_NONNULL_END
