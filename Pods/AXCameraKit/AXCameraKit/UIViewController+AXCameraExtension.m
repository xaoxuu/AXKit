//
//  UIViewController+AXCameraExtension.m
//  AXCameraKit
//
//  Created by xaoxuu on 18/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import "UIViewController+AXCameraExtension.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@import ObjectiveC.runtime;

static BOOL isActive = NO;
static id observer;
static const void *AXCameraExtensionImagePickerKey = &AXCameraExtensionImagePickerKey;
static const void *AXCameraExtensionOverlayViewKey = &AXCameraExtensionOverlayViewKey;
static const void *AXCameraExtensionCapturedImagesKey = &AXCameraExtensionCapturedImagesKey;

static inline BOOL isIphoneX(){
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}


@interface UIViewController() <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


/**
 captured images
 */
//@property (strong, nonatomic) NSMutableArray<UIImage *> *capturedImages;

@end

@implementation UIViewController (AXCameraExtension)

#pragma mark - life circle

- (UIImagePickerController *)imagePicker{
    return objc_getAssociatedObject(self, AXCameraExtensionImagePickerKey);
}
- (void)setImagePicker:(UIImagePickerController *)imagePicker{
    objc_setAssociatedObject(self, AXCameraExtensionImagePickerKey, imagePicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AXCameraOverlayView *)overlayView{
    return objc_getAssociatedObject(self, AXCameraExtensionOverlayViewKey);
}
- (void)setOverlayView:(AXCameraOverlayView *)overlayView{
    objc_setAssociatedObject(self, AXCameraExtensionOverlayViewKey, overlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//- (NSMutableArray<UIImage *> *)capturedImages{
//    return objc_getAssociatedObject(self, AXCameraExtensionCapturedImagesKey);
//}
//
//- (void)setCapturedImages:(NSMutableArray<UIImage *> *)capturedImages{
//    objc_setAssociatedObject(self, AXCameraExtensionCapturedImagesKey, capturedImages, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

/**
 加载相机，可以提前异步加载
 */
- (void)loadCameraKit{
    // @xaoxuu: 已经初始化
    if (self.imagePicker) {
        return;
    }
    // @xaoxuu: 没有后置摄像头
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        return;
    }
//    self.capturedImages = [NSMutableArray array];
    
    self.overlayView = [self setupOverlayView];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    self.imagePicker.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    
    //视频上传质量
    self.imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    //设置摄像头模式（拍照，录制视频）为录像模式
    self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    self.imagePicker.showsCameraControls = NO;
    
    self.imagePicker.cameraOverlayView = self.overlayView;
    
    
    CGFloat topHeight;
    if (isIphoneX()) {
        topHeight = 44 + 44; // 状态栏 + 导航栏
    } else {
        topHeight = 0;
    }
    
    CGRect pickerFrame = self.imagePicker.view.frame;
    pickerFrame.origin.y += topHeight;
    self.imagePicker.view.frame = pickerFrame;
    CGRect overlayFrame = self.overlayView.frame;
    overlayFrame.size.height = self.view.frame.size.height - self.view.frame.size.width * 4 / 3 - topHeight;
    overlayFrame.origin.y = self.view.frame.size.height - overlayFrame.size.height;
    self.overlayView.frame = overlayFrame;
    
}


/**
 添加对屏幕方向的监听，屏幕方向变动随时更新UI
 通过-[presentCameraVC:]方法弹出相机页面会自动执行此方法
 */
- (void)addObserverForDeviceOrientation{
    __weak typeof(self) weakSelf = self;
    observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf updateUIWithDeviceOrientation];
    }];
}

/**
 移除对屏幕方向的监听
 通过-[dismissCameraVC:]方法退出相机页面会自动执行此方法
 */
- (void)removeObserverForDeviceOrientation{
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
    observer = nil;
}

/**
 根据屏幕方向更新UI
 */
- (void)updateUIWithDeviceOrientation{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    CGAffineTransform transform;
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft) {
        transform = CGAffineTransformMakeRotation(M_PI_2);
    } else if (deviceOrientation == UIDeviceOrientationLandscapeRight) {
        transform = CGAffineTransformMakeRotation(-M_PI_2);
    } else if (deviceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        transform = CGAffineTransformMakeRotation(M_PI);
    } else {
        transform = CGAffineTransformIdentity;
    }
    
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.72f options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.overlayView.switchButton.transform = transform;
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - control

/**
 显示相机页面
 
 @param completion 完成回调
 */
- (void)presentCameraVC:(void (^)(void))completion{
    if (!isActive && self.imagePicker) {
        isActive = YES;
        __weak typeof(self) weakSelf = self;
        [weakSelf updateUIWithDeviceOrientation];
        [self presentViewController:self.imagePicker animated:YES completion:^{
            [weakSelf addObserverForDeviceOrientation];
            if (completion) {
                completion();
            }
            if ([weakSelf respondsToSelector:@selector(cameraDidPresented)]) {
                [weakSelf cameraDidPresented];
            }
        }];
    }
}

/**
 退出相机页面
 
 @param completion 完成回调
 */
- (void)dismissCameraVC:(void (^)(void))completion{
    isActive = NO;
    __weak typeof(self) weakSelf = self;
    [self.imagePicker dismissViewControllerAnimated:YES completion:^{
        [weakSelf removeObserverForDeviceOrientation];
        if (completion) {
            completion();
        }
        if ([weakSelf respondsToSelector:@selector(cameraDidDismissed)]) {
            [weakSelf cameraDidDismissed];
        }
    }];
}

/**
 拍照
 */
- (void)takePicture{
    [self.imagePicker takePicture];
}


#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
}

//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //        //如果是图片
        //        self.imageView.image = info[UIImagePickerControllerEditedImage];
        //        //压缩图片
        //        NSData *fileData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
        //        //保存图片至相册
        //        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //        //上传图片
        //        [self uploadImageWithData:fileData];
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        if (self.overlayView.isEnablePreview) {
            self.overlayView.previewImage = image;
        }
        if ([self respondsToSelector:@selector(cameraDidTakePicture:)]) {
            [self cameraDidTakePicture:image];
        }
    }else{
        //        //如果是视频
        //        NSURL *url = info[UIImagePickerControllerMediaURL];
        //        //播放视频
        //        _moviePlayer.contentURL = url;
        //        [_moviePlayer play];
        //        //保存视频至相册（异步线程）
        //        NSString *urlStr = [url path];
        //
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
        //
        //                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        //            }
        //        });
        //        NSData *videoData = [NSData dataWithContentsOfURL:url];
        //        //视频上传
        //        [self uploadVideoWithData:videoData];
    }
    //    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}



#pragma mark - button action

- (void)overlayButtonTapped:(UIButton *)sender{
    if (sender.tag == CameraOverlayButtonDismiss) {
        [self dismissCameraVC:nil];
    } else if (sender.tag == CameraOverlayButtonShutter) {
        [self takePicture];
    } else if (sender.tag == CameraOverlayButtonSwitch) {
        if (self.imagePicker.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
            self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        } else {
            self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
    }
}


#pragma mark - priv

- (AXCameraOverlayView *)setupOverlayView{
    CGRect frame = [UIScreen mainScreen].bounds;
    AXCameraOverlayView *overlayView = [[AXCameraOverlayView alloc] initWithFrame:frame];
    [overlayView.dismissButton addTarget:self action:@selector(overlayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [overlayView.shutterButton addTarget:self action:@selector(overlayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [overlayView.switchButton addTarget:self action:@selector(overlayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    return overlayView;
}




@end



