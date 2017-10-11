//
//  UIViewController+CameraExtension.m
//  AXKitDemo
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+CameraExtension.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CameraView.h"

static UIImagePickerController *picker;

@implementation UIViewController (CameraExtension)


- (void)showImagePicker{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    picker.allowsEditing = NO;
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    picker.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型
    picker.mediaTypes = @[(NSString *)kUTTypeImage];
    
    //视频上传质量
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    //设置摄像头模式（拍照，录制视频）为录像模式
    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    picker.showsCameraControls = NO;
    
    CameraView *view = UIViewFromNibNamed(@"CameraView");
    picker.cameraOverlayView = view;
    [view.cancelButton ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self dismiss];
    }];
    [view.takePhotoButton ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self takePhoto];
    }];
    
    [view.swapButton ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        if (picker.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
            picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        } else {
            picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
    }];
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)takePhoto{
    [picker takePicture];
}
- (void)dismiss{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    
}


@end


