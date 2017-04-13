//
//  ViewController.m
//  AXKitDemo
//
//  Created by ayan on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ViewController.h"
#import <AXKit/AXKit.h>
#import "MyButton.h"
#import "MyButton2.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *themeview;
@property (weak, nonatomic) IBOutlet UIView *accentview;
@property (weak, nonatomic) IBOutlet MyButton2 *myBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AXLogOBJ(self);
    AXLogSuccess();
    [NSUserDefaults ax_caches:^(NSUserDefaults * _Nonnull defaultUser) {
        [defaultUser ax_cacheBool:1 key:@""];
        
    }];
    [NSUserDefaults ax_readUserDefaultBoolWithKey:@""];
    
    // 要执行的代码
    [self.view ax_addRotationGesture:^(UIRotationGestureRecognizer * _Nonnull sender) {
        sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
        sender.rotation = 0;
    } handler:^(UIRotationGestureRecognizer * _Nonnull sender) {
        // 要执行的代码
    }];
    
    
    [self.myBtn ax_addTouchUpInsideHandler:^(__kindof UIButton * _Nonnull sender) {
        AXLogOBJ(NSStringFromCGFloat(1.2));
    }];
    
}

- (IBAction)btn:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            AXLogOBJ(@"a".readUserDefaultValue);
            AXLogBOOL(@"b".readUserDefaultBool);
            AXLogOBJ(@"c".readUserDefaultValue);
            break;
        case 1:
            AXLogOBJ(@"a".readUserDefaultValue);
            AXLogBOOL(@"b".readUserDefaultBool);
            AXLogOBJ(@"c".readUserDefaultValue);
            break;
        case 2:
            AXLogOBJ(@"a".readUserDefaultValue);
            AXLogBOOL(@"b".readUserDefaultBool);
            AXLogOBJ(@"c".readUserDefaultValue);
            break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.view.backgroundColor = axColor.background;
    self.themeview.backgroundColor = axColor.theme;
    self.accentview.backgroundColor = axColor.accent;
    AXLogFunc;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
