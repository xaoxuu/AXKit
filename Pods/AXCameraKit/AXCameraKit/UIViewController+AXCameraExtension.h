//
//  UIViewController+AXCameraExtension.h
//  AXCameraKit
//
//  Created by xaoxuu on 18/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXCameraOverlayView.h"

NS_ASSUME_NONNULL_BEGIN
/**
 相机代理，用于监听相机状态。无需手动设置代理。
 */
@protocol AXCameraKit

@optional

/**
 弹出相机页面的回调（present）
 */
- (void)cameraDidPresented;

/**
 退出相机页面的回调（dismiss）
 */
- (void)cameraDidDismissed;

/**
 拍照完成的回调

 @param image 照片
 */
- (void)cameraDidTakePicture:(UIImage *)image;

@end


/**
 需要在哪个页面弹出相机，就在哪个页面导入此分类。
 注意：不要放到全局头文件中。
 */
@interface UIViewController (AXCameraExtension) <AXCameraKit>


/**
 overlay view
 */
@property (strong, nonatomic) AXCameraOverlayView *overlayView;

/**
 image picker
 */
@property (strong, readonly, nonatomic) UIImagePickerController *imagePicker;




/**
 加载相机，可以根据需要提前异步加载
 */
- (void)loadCameraKit;

/**
 弹出相机页面

 @param completion 完成回调
 */
- (void)presentCameraVC:(void (^ _Nullable)(void))completion;

/**
 退出相机页面
 
 @param completion 完成回调
 */
- (void)dismissCameraVC:(void (^ _Nullable)(void))completion;

/**
 拍照
 */
- (void)takePicture;






/**
 添加对屏幕方向的监听，屏幕方向变动随时更新UI
 通过-[presentCameraVC:]方法弹出相机页面会自动执行此方法
 */
- (void)addObserverForDeviceOrientation;

/**
 移除对屏幕方向的监听
 通过-[dismissCameraVC:]方法退出相机页面会自动执行此方法
 */
- (void)removeObserverForDeviceOrientation;

/**
 根据屏幕方向更新UI
 */
- (void)updateUIWithDeviceOrientation;

@end
NS_ASSUME_NONNULL_END
