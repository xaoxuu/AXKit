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

@property (strong, nonatomic) NSMutableDictionary<NSString *, BlockType> *actions;

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
    actionIndex = CameraOverlayButtonDismiss;
    self.backgroundColor = [UIColor blackColor];
    UIButton *dismiss = [self buttonWithImageName:@"ax_camera_dismiss" highlighted:NO action:nil];
    UIButton *shutter = [self buttonWithImageName:@"ax_camera_shutter" highlighted:YES action:nil];
    UIButton *switchCamera = [self buttonWithImageName:@"ax_camera_switch" highlighted:NO action:nil];
    [self addSubview:dismiss];
    [self addSubview:shutter];
    [self addSubview:switchCamera];
    self.dismiss = dismiss;
    self.shutter = shutter;
    self.switchCamera = switchCamera;
    // layout ok
    CGRect frame = shutter.frame;
    frame.origin.x = (self.frame.size.width - frame.size.width) / 2;
    frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
    shutter.frame = frame;
    // layout cancel
    frame.origin.x = margin;
    dismiss.frame = frame;
    // layout switch
    frame.origin.x = self.frame.size.width - frame.size.width - margin;
    switchCamera.frame = frame;
}

- (UIButton *)buttonWithImageName:(NSString *)imageName highlighted:(BOOL)highlighted action:(BlockType)action{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, normalButtonSize, normalButtonSize)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 0.5 * fmin(btn.layer.frame.size.width, btn.layer.frame.size.height);
    [btn setImage:[self loadImageWithName:imageName] forState:UIControlStateNormal];
    btn.tag = actionIndex++;
    if (highlighted) {
    }
    if (action) {
        self.actions[stringFromInteger(btn.tag)] = action;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

- (UIImage *)loadImageWithName:(NSString *)name{
    // @xaoxuu: in main bundle/AXCameraKit.bundle
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"123");
}


@end
