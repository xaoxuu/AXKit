//
//  ResizeableImageVC.m
//  AXKit
//
//  Created by xaoxuu on 25/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ResizeableImageVC.h"

@interface ResizeableImageVC ()
@property (weak, nonatomic) IBOutlet UIView *targetView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@property (weak, nonatomic) IBOutlet UIView *moveGestureView;

@property (weak, nonatomic) IBOutlet UIView *resizeGestureView;

@property (weak, nonatomic) IBOutlet UITextView *textV;

@end

@implementation ResizeableImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.targetView ax_layer:^(CALayer * _Nonnull layer) {
        [layer ax_cornerRadius:8 shadow:LayerShadowDownNormal];
    }];
    [self.moveGestureView.layer ax_maskToCircle];
    [self.resizeGestureView.layer ax_maskToCircle];
    
    
    UIImage *image = [UIImage imageNamed:@"chat"];
    CGFloat x = image.size.width / 2;
    CGFloat y = image.size.height / 2;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1.1*y, 1.2*x, 0.9*y, 0.8*x) resizingMode:UIImageResizingModeStretch];
    self.bgImageView.image = image;
    
    __weak typeof(self) weakSelf = self;
    [self.moveGestureView ax_addPanGesture:nil handler:^(UIPanGestureRecognizer * _Nonnull sender) {
        CGPoint po = [sender translationInView:weakSelf.view];
        weakSelf.targetView.left += po.x;
        weakSelf.targetView.top += po.y;
        [sender setTranslation:CGPointZero inView:weakSelf.view];
    }];
    [self.resizeGestureView ax_addPanGesture:^(UIPanGestureRecognizer * _Nonnull sender) {
        
    } handler:^(UIPanGestureRecognizer * _Nonnull sender) {
        CGPoint po = [sender translationInView:weakSelf.view];
        CGFloat w = weakSelf.targetView.width + po.x;
        CGFloat h = weakSelf.targetView.height + po.y;
        weakSelf.targetView.width = w;
        weakSelf.targetView.height = h;
        weakSelf.resizeGestureView.right = w;
        weakSelf.resizeGestureView.bottom = h;
        weakSelf.bgImageView.width = w-16;
        weakSelf.bgImageView.height = h-16;
        
        
        weakSelf.textV.width = w-40;
        weakSelf.textV.height = h-68;
        
        [sender setTranslation:CGPointZero inView:weakSelf.view];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
