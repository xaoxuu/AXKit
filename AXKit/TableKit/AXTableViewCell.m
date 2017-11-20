//
//  AXTableViewCell.m
//  AXTableKit
//
//  Created by xaoxuu on 27/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import "AXTableViewCell.h"
#import "UIThemeManager.h"

static CGFloat margin = 8;
static CGFloat cellHeight = 44;
static CGFloat cellWidth = 375;
static CGFloat maxImageWidth = 40;

static CGFloat getAccessoryWidth(UITableViewCellAccessoryType type){
    switch (type) {
        case UITableViewCellAccessoryNone:
            return 16;
        case UITableViewCellAccessoryDisclosureIndicator:
            return 33;
        case UITableViewCellAccessoryDetailDisclosureButton:
            return 67;
        case UITableViewCellAccessoryCheckmark:
            return 39;
        case UITableViewCellAccessoryDetailButton:
            return 47;
    }
}

@interface AXTableViewCell ()

@property (strong, nonatomic) UILabel *title;

@property (strong, nonatomic) UILabel *detail;


@end


@implementation AXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self _init];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self _init];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self _init];
    }
    return self;
}

- (void)_init{
    
    
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(2 * margin, margin, cellHeight - 2 * margin, cellHeight - 2 * margin)];
    _icon.layer.masksToBounds = YES;
    _icon.layer.cornerRadius = 8;
    [self.contentView addSubview:self.icon];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(cellHeight, 0, cellWidth - 2*cellHeight, cellHeight)];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.font = [self fontForTitle];
    [self.contentView addSubview:self.title];
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth - cellHeight, 0, cellHeight, cellHeight)];
    self.detail.textAlignment = NSTextAlignmentRight;
    self.detail.font = [self fontForDetail];
    self.detail.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.detail];
    NSLog(@"{%f,%f}", self.frame.size.width, self.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setModel:(NSObject<AXTableRowModel> *)model{
    _model = model;
    self.title.font = [self fontForTitle];
    self.detail.font = [self fontForDetail];
    if (self.frame.size.width) {
        cellWidth = self.contentView.frame.size.width;
    }
    if (self.frame.size.height) {
        cellHeight = self.contentView.frame.size.height;
    }
    self.title.text = model.title;
    self.detail.text = model.detail;
    self.icon.image = [self imageWithPath:model.icon];
    if ([model respondsToSelector:@selector(accessoryType)]) {
        self.accessoryType = model.accessoryType;
    }
    [self updateFrame];
}

- (UIFont *)fontForTitle{
    return [UIThemeManager sharedInstance].font.customNormal;
}
- (UIFont *)fontForDetail{
    return [UIThemeManager sharedInstance].font.customSmall;
}

- (void)updateFrame{
    CGRect frame;
    CGFloat imageWidth = 0;
    if (self.accessoryView) {
        cellWidth = self.frame.size.width - self.accessoryView.frame.size.width - 3 * margin;
    } else {
        cellWidth = self.frame.size.width - getAccessoryWidth(self.accessoryType);
    }
    static CGFloat titleWidth = 0;
    static CGFloat detailWidth = 0;
    if (self.icon.image) {
        imageWidth = self.icon.frame.size.width;
        if (imageWidth > maxImageWidth) {
            imageWidth = maxImageWidth;
        }
        self.icon.frame = CGRectMake(2 * margin, (cellHeight - imageWidth)/2, imageWidth, imageWidth);
        imageWidth += margin;
    } else {
        imageWidth = 0;
    }
    frame = self.detail.frame;
    NSDictionary *dict = @{NSFontAttributeName: self.detail.font};
    detailWidth = [self.detail.text boundingRectWithSize:CGSizeMake(0.5*cellWidth - imageWidth, cellHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size.width;
    frame.size.width = detailWidth;
    frame.origin.x = cellWidth - detailWidth;
    
    self.detail.frame = frame;
    
    frame = self.title.frame;
    dict = @{NSFontAttributeName: self.title.font};
    frame.origin.x = 2 * margin + imageWidth;
    titleWidth = [self.title.text boundingRectWithSize:CGSizeMake(self.detail.frame.origin.x - frame.origin.x - margin, cellHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size.width;
    frame.size.width = titleWidth;
    self.title.frame = frame;
    
}

- (UIImage *)imageWithPath:(NSString *)path{
    UIImage *image;
    image = [UIImage imageNamed:path];
    if (!image) {
        image = [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
    }
    if (!image) {
#if DEBUG
//        NSLog(@"本地找不到图片，需要从网络加载");
#endif
        
    }
    return image;
}

- (void)updateIcon:(void (^)(UIImageView *))icon{
    if (icon) {
        icon(self.icon);
    }
    [self updateFrame];
}

@end
