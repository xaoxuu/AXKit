//
//  FeedbackVC.m
//  AXKit
//
//  Created by xaoxuu on 08/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FeedbackVC.h"
#import "FeedbackKit.h"

@interface FeedbackVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *seg_subject;
@property (weak, nonatomic) IBOutlet UITextView *tv_content;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (strong, nonatomic) UIImage *img;

@property (weak, nonatomic) IBOutlet UITextField *tf_summary;


@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}



- (void)initContentView:(UIView *)view{
    self.seg_subject.tintColor = axThemeManager.color.theme.isLightColor?axThemeManager.color.theme.darkRatio(0.3):axThemeManager.color.theme;
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithImageName:@"send" action:^(id  _Nonnull sender) {
        [weakSelf sendEmail:^(MFMailComposeViewController *mailCompose) {
            
            // 设置邮件主题
            NSString *title = [weakSelf.seg_subject titleForSegmentAtIndex:weakSelf.seg_subject.selectedSegmentIndex];
            [mailCompose setSubject:[NSString stringWithFormat:@"[%@] - %@",title, weakSelf.tf_summary.text]];
            // 设置收件人
            [mailCompose setToRecipients:@[@"xaoxuu@gmail.com"]];
            NSString *emailContent = weakSelf.tv_content.text;
            [mailCompose setMessageBody:emailContent isHTML:NO];
            
        } completion:^(MFMailComposeResult result) {
            
            [UIAlertController ax_showAlertWithTitle:NSStringFromNSInteger(result) message:nil actions:nil];
        } fail:^(NSError *error) {
            [UIAlertController ax_showAlertWithTitle:@"无法发送邮件" message:nil actions:nil];
        }];
    }];
    
}




@end
