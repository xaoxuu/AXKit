//
//  AXCameraOverlayView.m
//  AXCameraKit
//
//  Created by xaoxuu on 18/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import "AXCameraOverlayView.h"

static CGFloat margin = 16;
static CGFloat normalButtonSize = 64.0f;


static NSString *moduleName = @"AXCameraKit";
typedef void(^BlockType)(void);
static NSInteger actionIndex = CameraOverlayButtonDismiss;
static NSString *stringFromInteger(NSInteger index){
    return [NSString stringWithFormat:@"%ld", (long)index];
}


@interface AXCameraOverlayView()

/**
 操作区域的图层
 */
@property (strong, nonatomic) UIView *overlayView;

@property (strong, nonatomic) NSMutableDictionary<NSString *, BlockType> *actions;
/**
 预览照片按钮
 */
@property (strong, nonatomic) UIButton *previewButton;


@end

@implementation AXCameraOverlayView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _actions = [NSMutableDictionary dictionary];
        [self _init];
    }
    return self;
}

- (void)_init{
    // const
    actionIndex = CameraOverlayButtonDismiss;
    
    // overlay
    [self _initOverlayView];
    
    // preview
    self.previewButton = [self buttonWithImageName:nil action:^{
        // preview image
    }];
    self.previewButton.layer.cornerRadius = 4;
    [self addSubview:self.previewButton];
    
    // update frame
    self.frame = self.frame;
    
    // front camera available
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        self.switchButton.userInteractionEnabled = YES;
        self.switchButton.alpha = 1;
    } else {
        self.switchButton.userInteractionEnabled = NO;
        self.switchButton.alpha = 0.5;
    }
    
    // 默认不显示预览
    self.enablePreview = NO;
}

- (void)_initOverlayView{
    // overlay
    self.overlayView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.overlayView];
    // buttons
    self.dismissButton = [self buttonWithImageName:@"ax_camera_dismiss" action:nil];
    self.shutterButton = [self buttonWithImageName:@"ax_camera_shutter" action:nil];
    self.switchButton = [self buttonWithImageName:@"ax_camera_switch" action:nil];
    
    [self.overlayView addSubview:self.dismissButton];
    [self.overlayView addSubview:self.shutterButton];
    [self.overlayView addSubview:self.switchButton];
    CGFloat margin = 16;
    self.dismissButton.imageEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
    margin = 18;
    self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    CGRect overlayFrame = frame;
    overlayFrame.size.height = frame.size.height - frame.size.width * 4 / 3;
    overlayFrame.origin.y = frame.size.height - overlayFrame.size.height;
    [self updateOverlayFrame:overlayFrame];
    
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [self.overlayView setBackgroundColor:backgroundColor];
}

- (void)setEnablePreview:(BOOL)enablePreview{
    _enablePreview = enablePreview;
    self.previewButton.hidden = !enablePreview;
}

- (void)updateOverlayFrame:(CGRect)frame{
    CGFloat minHeight = normalButtonSize + 2 * margin;
    CGFloat offset = frame.size.height - minHeight;
    if (offset < 0) {
        frame.size.height = minHeight;
        frame.origin.y += offset;
    }
    self.overlayView.frame = frame;
    // layout shutter button
    CGRect tmpFrame = self.shutterButton.frame;
    tmpFrame.origin.x = (frame.size.width - tmpFrame.size.width) / 2;
    tmpFrame.origin.y = (frame.size.height - tmpFrame.size.height) / 2;
    self.shutterButton.frame = tmpFrame;
    // layout dismiss button
    tmpFrame.origin.x = margin;
    self.dismissButton.frame = tmpFrame;
    // layout switch button
    tmpFrame.origin.x = frame.size.width - tmpFrame.size.width - margin;
    self.switchButton.frame = tmpFrame;
    
    // preview
    CGFloat previewHeight = 50;
    self.previewButton.frame = CGRectMake(8, frame.origin.y - previewHeight - 8, previewHeight * 3 / 4, previewHeight);
}

- (void)setPreviewImage:(UIImage *)previewImage{
    _previewImage = previewImage;
    [self.previewButton setImage:previewImage forState:UIControlStateNormal];
}

- (UIButton *)buttonWithImageName:(NSString *)imageName action:(BlockType)action{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, normalButtonSize, normalButtonSize)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 0.5 * fmin(btn.layer.frame.size.width, btn.layer.frame.size.height);
    if (imageName.length) {
        [btn setImage:[self loadImageWithName:imageName] forState:UIControlStateNormal];
    }
    btn.tag = actionIndex++;
    if (action) {
        self.actions[stringFromInteger(btn.tag)] = action;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

- (UIImage *)loadImageWithName:(NSString *)name{
    // in mainBundle/AXCameraKit.bundle
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:moduleName ofType:@"bundle"]];
    UIImage *img = [self loadImageWithBundle:bundle name:name];
    if (!img) {
        NSString *path_frameworks = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Frameworks"];
        path_frameworks = [[path_frameworks stringByAppendingPathComponent:moduleName] stringByAppendingPathExtension:@"framework"];
        bundle = [NSBundle bundleWithPath:path_frameworks];
        bundle = [NSBundle bundleWithPath:[bundle pathForResource:moduleName ofType:@"bundle"]];
        img = [self loadImageWithBundle:bundle name:name];
    }
    return img;
}

- (UIImage *)loadImageWithBundle:(NSBundle *)bundle name:(NSString *)name{
    NSString *path = [bundle pathForResource:name ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    return img;
}

- (void)btnAction:(UIButton *)sender{
    BlockType action = self.actions[stringFromInteger(sender.tag)];
    if (action) {
        action();
    }
}



@end
