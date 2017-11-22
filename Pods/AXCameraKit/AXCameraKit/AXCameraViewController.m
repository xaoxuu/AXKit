//
//  AXCameraViewController.m
//  AXCameraKit
//
//  Created by xaoxuu on 21/11/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import "AXCameraViewController.h"
#import <AVFoundation/AVFoundation.h>


static NSString *moduleName = @"AXCameraKit";

@interface AXCameraViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>

/**
 捕获设备
 */
@property(nonatomic)AVCaptureDevice *cameraDdevice;

/**
 输入设备
 */
@property(nonatomic)AVCaptureDeviceInput *input;

/**
 图像输出
 */
@property (nonatomic)AVCaptureStillImageOutput *imageOutput;

/**
 捕获回话，将输入输出结合
 */
@property(nonatomic)AVCaptureSession *captureSession;

/**
 图像预览层，实时显示捕获的图像
 */
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;


/**
 闪光灯
 */
@property (nonatomic)UIButton *flashlightButton;

/**
 对焦框
 */
@property (nonatomic)UIView *focusView;

@end

@implementation AXCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 是否有相机
    BOOL supportCamera = NO;
    NSArray<AVCaptureDevice *> *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    supportCamera = cameras.count > 0;
    // 是否有权限
    if (supportCamera) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied) {
            supportCamera = NO;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法打开相机" message:@"请打开相机权限：【设置-隐私-相机】" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:ok];
            [alert addAction:cancel];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
            });
        } else {
            // 可以拍照
            [self customCamera];
            [self customUI];
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法打开相机" message:@"设备不支持相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        });
    }
    
}

- (void)dealloc{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)customUI{
    self.focusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.focusView.layer.borderWidth = 1.0;
    self.focusView.layer.borderColor =[UIColor greenColor].CGColor;
    self.focusView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.focusView];
    self.focusView.hidden = YES;

    
    AXCameraOverlayView *overlay = [self setupOverlayView];
    self.overlayView = overlay;
    [self.view addSubview:overlay];
    self.overlayView.enablePreview = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}
- (void)customCamera{
    
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
    self.cameraDdevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //使用设备初始化输入
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.cameraDdevice error:nil];
    
    //生成输出对象
//    self.output = [[AVCaptureMetadataOutput alloc]init];
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    //生成会话，用来结合输入输出
    self.captureSession = [[AVCaptureSession alloc]init];
    self.captureSession.sessionPreset = [self maxCaptureSessionPreset];
    
    
    if ([self.captureSession canAddInput:self.input]) {
        [self.captureSession addInput:self.input];
    }
    
    if ([self.captureSession canAddOutput:self.imageOutput]) {
        [self.captureSession addOutput:self.imageOutput];
    }
    
    //使用self.captureSession，初始化预览层，self.captureSession负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    self.previewLayer.frame = [UIScreen mainScreen].bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    //开始启动
    [self.captureSession startRunning];
    if ([self.cameraDdevice lockForConfiguration:nil]) {
        if ([self.cameraDdevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [self.cameraDdevice setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡
        if ([self.cameraDdevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [self.cameraDdevice setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [self.cameraDdevice unlockForConfiguration];
    }
    
}

// 开关闪光灯
- (void)switchFlashlight{
    UIButton *sender = self.overlayView.flashlightButton;
    static NSInteger state;
    // state: 0:auto 1:on 2:off
    if ([self.cameraDdevice lockForConfiguration:nil]) {
        if (state == 0) {
            if ([self.cameraDdevice isFlashModeSupported:AVCaptureFlashModeOn]) {
                state = 1;
                [self.cameraDdevice setFlashMode:AVCaptureFlashModeOn];
                [sender setImage:[self.overlayView loadImageWithName:@"ax_camera_flash_on"] forState:UIControlStateNormal];
            }
        } else if (state == 1) {
            if ([self.cameraDdevice isFlashModeSupported:AVCaptureFlashModeOff]) {
                state = 2;
                [self.cameraDdevice setFlashMode:AVCaptureFlashModeOff];
                [sender setImage:[self.overlayView loadImageWithName:@"ax_camera_flash_off"] forState:UIControlStateNormal];
            }
            
        } else {
            if ([self.cameraDdevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
                state = 0;
                [self.cameraDdevice setFlashMode:AVCaptureFlashModeAuto];
                [sender setImage:[self.overlayView loadImageWithName:@"ax_camera_flash_auto"] forState:UIControlStateNormal];
            }
        }
        [self.cameraDdevice unlockForConfiguration];
    }
}

- (void)switchCameraDevice{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSError *error;
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5f;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            
            animation.type = @"oglFlip";
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            AVCaptureDevicePosition position = self.input.device.position;
            if (position == AVCaptureDevicePositionFront){
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
                animation.subtype = kCATransitionFromLeft;
            } else {
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
                animation.subtype = kCATransitionFromRight;
            }
            
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            if (newInput != nil) {
                [self.captureSession beginConfiguration];
                [self.captureSession removeInput:self.input];
                if ([self.captureSession canAddInput:newInput]) {
                    
                    [self.captureSession addInput:newInput];
                    self.input = newInput;
                } else {
                    [self.captureSession addInput:self.input];
                }
                [self.captureSession commitConfiguration];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.previewLayer addAnimation:animation forKey:nil];
                });
                
            } else if (error) {
                NSLog(@"toggle carema failed, error = %@", error);
            }
        });
        
    }
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices ) {
        if ( device.position == position ) {
            return device;
        }
    }
    return nil;
}

#pragma mark 点击手势：对焦
- (void)focusGesture:(UITapGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    [self focusAtPoint:point];
}

- (void)focusAtPoint:(CGPoint)point{
    CGSize size = self.view.bounds.size;
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
    NSError *error;
    if ([self.cameraDdevice lockForConfiguration:&error]) {
        
        if ([self.cameraDdevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.cameraDdevice setFocusPointOfInterest:focusPoint];
            [self.cameraDdevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        
        if ([self.cameraDdevice isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.cameraDdevice setExposurePointOfInterest:focusPoint];
            [self.cameraDdevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        
        [self.cameraDdevice unlockForConfiguration];
        self.focusView.center = point;
        self.focusView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.focusView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.focusView.hidden = YES;
            }];
        }];
    }
    
}

#pragma mark - 拍照
- (void)takePicture {
    AVCaptureConnection * videoConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:imageData];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        if (self.overlayView.isEnablePreview) {
            self.overlayView.previewImage = image;
        }
        
    }];
}

#pragma mark 相册保存回调
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    if(error != NULL){
#if DEBUG
        NSLog(@"图片保存失败：%@", error.localizedDescription);
#endif
    }
}


#pragma mark - 按钮点击事件

- (void)overlayButtonTapped:(UIButton *)sender{
    if (sender.tag == CameraOverlayButtonDismiss) {
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (sender.tag == CameraOverlayButtonShutter) {
        [self takePicture];
    } else if (sender.tag == CameraOverlayButtonSwitch) {
        [self switchCameraDevice];
    } else if (sender.tag == CameraOverlayButtonFlashlight) {
        [self switchFlashlight];
    }
}

#pragma mark - priv

// 设备支持的质量
- (AVCaptureSessionPreset)maxCaptureSessionPreset{
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetPhoto]) {
        return AVCaptureSessionPresetPhoto;
    } else if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        return AVCaptureSessionPresetHigh;
    } else if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetMedium]) {
        return AVCaptureSessionPresetMedium;
    } else {
        return AVCaptureSessionPresetLow;
    }
}

- (AXCameraOverlayView *)setupOverlayView{
    CGRect frame = [UIScreen mainScreen].bounds;
    AXCameraOverlayView *overlayView = [[AXCameraOverlayView alloc] initWithFrame:frame];
    [overlayView.flashlightButton addTarget:self action:@selector(overlayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [overlayView.dismissButton addTarget:self action:@selector(overlayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [overlayView.shutterButton addTarget:self action:@selector(overlayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        [overlayView.switchButton addTarget:self action:@selector(overlayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        overlayView.switchButton.hidden = YES;
    }
    
    return overlayView;
}



@end
