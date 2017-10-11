//
//  UIViewController+CameraExtension.h
//  AXKitDemo
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CameraExtension)<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (void)showImagePicker;

- (void)takePhoto;

@end
