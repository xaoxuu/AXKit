//
//  CustomTableVC.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CustomTableVC.h"

@interface CustomTableVC ()

@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UITextField *tf_detail;


@end

@implementation CustomTableVC

+ (instancetype)defaultVCWithTitle:(NSString *)title detail:(NSString *)detail{
    return [[self alloc] initWithTitle:title detail:detail];
}

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail{
    if (self = [super init]) {
        self.title = title;
        self.detail = detail;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lb_title.text = self.title;
    self.tf_detail.text = self.detail;
    
    if ([self.cmd isEqualToString:@"margin"]) {
        [self.tf_detail ax_addEditingEndHandler:^(__kindof UITextField * _Nonnull sender) {
            
            CGFloat height = self.tf_detail.text.floatValue;
            height = AXMakeFloatInRange(height, AXFloatRangeMake(32, 1000));
            self.tf_detail.text = NSStringFromCGFloat(height);
            
            [services.cache updateSetting:^(NSMutableArray<BaseTableModelSection *> *setting) {
                for (BaseTableModelSection *sec in setting) {
                    sec.header_height = NSStringFromCGFloat(height);
                    for (BaseTableModelRow *row in sec.rows) {
                        if ([row.title isEqualToString:@"组间距"]) {
                            row.desc = NSStringFromCGFloat(height);
                        }
                    }
                }
            }];
            [self.navigationController popViewControllerAnimated:YES];
        }];

    } else if ([self.cmd isEqualToString:@"rowHeight"]) {
        [self.tf_detail ax_addEditingEndHandler:^(__kindof UITextField * _Nonnull sender) {
            
            CGFloat height = self.tf_detail.text.floatValue;
            height = AXMakeFloatInRange(height, AXFloatRangeMake(32, 80));
            self.tf_detail.text = NSStringFromCGFloat(height);
            [services.cache updateSetting:^(NSMutableArray<BaseTableModelSection *> *setting) {
                for (BaseTableModelSection *sec in setting) {
                    sec.rowHeight = NSStringFromCGFloat(height);
                    for (BaseTableModelRow *row in sec.rows) {
                        if ([row.title isEqualToString:@"行高"]) {
                            row.desc = NSStringFromCGFloat(height);
                        }
                    }
                }
            }];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.tf_detail resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tf_detail resignFirstResponder];
}



@end
