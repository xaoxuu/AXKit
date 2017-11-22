//
//  AXCameraOverlayView.m
//  AXCameraKit
//
//  Created by xaoxuu on 18/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import "AXCameraOverlayView.h"

static CGFloat margin = 16;
static CGFloat smallButtonSize = 40.0f;
static CGFloat normalButtonSize = 64.0f;
static CGFloat overlayHeight = 128.0f;

static NSString *moduleName = @"AXCameraKit";
typedef void(^BlockType)(void);
static NSInteger actionIndex = CameraOverlayButtonDismiss;
static NSString *stringFromInteger(NSInteger index){
    return [NSString stringWithFormat:@"%ld", (long)index];
}

static inline BOOL isIphoneX(){
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}

@interface AXCameraOverlayView()

/**
 底部操作区域的图层
 */
@property (strong, nonatomic) UIView *bottomOverlayView;

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
        NSString *url = @"photos-redirect://";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
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
    self.bottomOverlayView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.bottomOverlayView];
    self.bottomOverlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    
    // bottom buttons
    self.dismissButton = [self buttonWithImageName:@"ax_camera_dismiss" action:nil];
    self.shutterButton = [self buttonWithImageName:@"ax_camera_shutter" action:nil];
    self.switchButton = [self buttonWithImageName:@"ax_camera_switch" action:nil];
    
    [self.bottomOverlayView addSubview:self.dismissButton];
    [self.bottomOverlayView addSubview:self.shutterButton];
    [self.bottomOverlayView addSubview:self.switchButton];
    
    // top buttons
    self.flashlightButton = [self buttonWithImageName:@"ax_camera_flash_auto" action:nil];
    self.flashlightButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [self addSubview:self.flashlightButton];
    
    CGFloat margin = 8;
    self.flashlightButton.imageEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
    margin = 16;
    self.dismissButton.imageEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
    margin = 18;
    self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    CGRect bottomFrame = frame;
    CGFloat height = overlayHeight;
    if (isIphoneX()) {
        height += 34;
    }
    bottomFrame.size.height = height;
    bottomFrame.origin.y = frame.size.height - bottomFrame.size.height;
    [self updateBottomOverlayFrame:bottomFrame];
    
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [self.bottomOverlayView setBackgroundColor:backgroundColor];
}

- (void)setEnablePreview:(BOOL)enablePreview{
    _enablePreview = enablePreview;
    self.previewButton.hidden = !enablePreview;
}

- (void)updateBottomOverlayFrame:(CGRect)frame{
    // bottom
    CGFloat minHeight = normalButtonSize + 2 * margin;
    CGFloat offset = frame.size.height - minHeight;
    if (offset < 0) {
        frame.size.height = minHeight;
        frame.origin.y += offset;
    }
    self.bottomOverlayView.frame = frame;
    // layout shutter button
    CGRect tmpFrame = self.shutterButton.frame;
    tmpFrame.origin.x = (frame.size.width - tmpFrame.size.width) / 2;
    tmpFrame.origin.y = 32;
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
    self.flashlightButton.frame = CGRectMake(frame.size.width - smallButtonSize - 8, frame.origin.y - smallButtonSize - 8, smallButtonSize, smallButtonSize);
    self.flashlightButton.layer.cornerRadius = 0.5 * smallButtonSize;
    
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
