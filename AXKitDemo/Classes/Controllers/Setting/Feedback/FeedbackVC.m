//
//  FeedbackVC.m
//  AXKit
//
//  Created by xaoxuu on 08/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FeedbackVC.h"
#import "FeedbackKit.h"
#import "FeedbackCollectionViewCell.h"

static NSString *reuseId = @"FeedbackCollectionViewCell";
static NSInteger count = 3;
static CGFloat margin = 4;

@interface FeedbackVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FeedbackCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *seg_subject;
@property (weak, nonatomic) IBOutlet UITextView *tv_content;

@property (strong, nonatomic) UIImage *img;

@property (weak, nonatomic) IBOutlet UITextField *tf_summary;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (strong, nonatomic) NSMutableArray<UIImage *> *images;


@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tv_content.layer ax_borderWidth:0.5 color:[UIColor colorWithWhite:0 alpha:0.2]];
    [self.tv_content.layer ax_cornerRadius:5 shadow:LayerShadowNone];
    self.images = [NSMutableArray array];
    [self setupCollectionView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


- (void)setupCollectionView{
    
    self.collection.dataSource = self;
    self.collection.delegate = self;
    [self.collection registerNib:[UINib nibWithNibName:reuseId bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseId];
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    NSInteger count = 4;
//    CGFloat margin = 4;
//    CGFloat width = (self.collection.width - (count - 1) * margin) / count;
//    CGFloat height = width * kScreenH / kScreenW;
//    layout.itemSize = CGSizeMake(width, height);
////    layout.minimumInteritemSpacing = margin;
//    layout.minimumLineSpacing = margin;
//    self.collection.collectionViewLayout = layout;
    
}


- (void)initContentView:(UIView *)view{
    self.seg_subject.tintColor = axThemeManager.color.theme.isLightColor?axThemeManager.color.theme.darkRatio(0.3):axThemeManager.color.theme;
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithImageName:@"send" action:^(id  _Nonnull sender) {
        [[EmailManager sharedInstance] sendEmail:^(MFMailComposeViewController *mailCompose) {
            
            // 设置邮件主题
            NSString *title = [weakSelf.seg_subject titleForSegmentAtIndex:weakSelf.seg_subject.selectedSegmentIndex];
            [mailCompose setSubject:[NSString stringWithFormat:@"[%@] - %@",title, weakSelf.tf_summary.text]];
            
            NSString *emailContent = weakSelf.tv_content.text;
            [mailCompose setMessageBody:emailContent isHTML:NO];
            
            [self.images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [mailCompose addAttachmentData:UIImagePNGRepresentation(obj) mimeType:@"png" fileName:@"image.png"];
            }];
            
        } completion:^(MFMailComposeResult result) {
            
            [UIAlertController ax_showAlertWithTitle:NSStringFromNSInteger(result) message:nil actions:nil];
        } fail:^(NSError *error) {
            [UIAlertController ax_showAlertWithTitle:@"无法发送邮件" message:nil actions:nil];
        }];
    }];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count + 1;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FeedbackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    if (indexPath.row < self.images.count) {
        cell.image = self.images[indexPath.row];
    } else {
        cell.delegate = self;
    }
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (self.collection.width - (count - 1) * margin) / count;
    CGFloat height = width * kScreenH / kScreenW;
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return margin;
}

- (void)didAddedImage:(UIImage *)image{
    [self.images addObject:image];
    [self.collection reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.images.count inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    });
}

@end
