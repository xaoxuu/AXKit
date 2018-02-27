//
//  FeedbackCollectionViewCell.m
//  AXKitDemo
//
//  Created by xaoxuu on 04/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FeedbackCollectionViewCell.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface FeedbackCollectionViewCell () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UIImageView *imgv;

@property (strong, nonatomic) UIImagePickerController *picker;

@end

@implementation FeedbackCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


- (void)setImage:(UIImage *)image{
    _image = image;
    self.imgv.image = image;
    self.add.hidden = image;
    
}
- (IBAction)btnTapped:(UIButton *)sender {
    [self.controller presentViewController:self.picker animated:YES completion:nil];
}


- (UIImagePickerController *)picker{
    if (!_picker) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        _picker = picker;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    }
    return _picker;
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // image
    if ([info[UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeImage]) {
        // @xaoxuu: data
        NSData *data = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage]);
        UIImage *image = [UIImage imageWithData:data];
        if (image && [self.delegate respondsToSelector:@selector(didAddedImage:)]) {
            [self.delegate didAddedImage:image];
        }
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
