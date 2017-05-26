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
    
    self.targetView.layer.cornerRadius = 8;
    self.targetView.layer.ax_shadow(AXShadowDownNormal);
    self.moveGestureView.layer.ax_maskToCircle();
    self.resizeGestureView.layer.ax_maskToCircle();
    
    UIImage *image = [UIImage imageNamed:@"chat"];
    CGFloat x = image.size.width / 2;
    CGFloat y = image.size.height / 2;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1.1*y, 1.2*x, 0.9*y, 0.8*x) resizingMode:UIImageResizingModeStretch];
    self.bgImageView.image = image;
    
    
    [self.moveGestureView ax_addPanGesture:nil handler:^(UIPanGestureRecognizer * _Nonnull sender) {
        CGPoint po = [sender translationInView:self.view];
        self.targetView.left += po.x;
        self.targetView.top += po.y;
        [sender setTranslation:CGPointZero inView:self.view];
    }];
    [self.resizeGestureView ax_addPanGesture:^(UIPanGestureRecognizer * _Nonnull sender) {
        
    } handler:^(UIPanGestureRecognizer * _Nonnull sender) {
        CGPoint po = [sender translationInView:self.view];
        CGFloat w = self.targetView.width + po.x;
        CGFloat h = self.targetView.height + po.y;
        self.targetView.width = w;
        self.targetView.height = h;
        self.resizeGestureView.right = w;
        self.resizeGestureView.bottom = h;
        self.bgImageView.width = w-16;
        self.bgImageView.height = h-16;
        
        
        self.textV.width = w-40;
        self.textV.height = h-68;
        
        [sender setTranslation:CGPointZero inView:self.view];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
