//
//  FeedbackCollectionViewCell.h
//  AXKitDemo
//
//  Created by xaoxuu on 04/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedbackCollectionViewCellDelegate

- (void)didAddedImage:(UIImage *)image;

@end

@interface FeedbackCollectionViewCell : UICollectionViewCell

// @xaoxuu: image
@property (strong, nonatomic) UIImage *image;

// @xaoxuu: delegate
@property (weak, nonatomic) NSObject<FeedbackCollectionViewCellDelegate> *delegate;

@end
