//
//  ZZEmptyView.m
//  TalentService
//
//  Created by zhizhen on 15/9/28.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZEmptyView.h"

@interface ZZEmptyView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation ZZEmptyView
+ (instancetype)emptyView{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZZEmptyView" owner:nil options:nil]lastObject];
}
-(void)awakeFromNib{
    self.backgroundColor = ZZRGBCloor(241, 242, 246);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
}
-(void)setIcon:(NSString *)icon{
    _icon = icon;
    
    UIImage *image = [UIImage  imageNamed:icon];
    self.imageView.bounds = (CGRect){{0,0},image.size};
    self.imageView.image  = image;
  
    [self  setNeedsLayout];
}

-(void)setTipTitle:(NSString *)tipTitle{
    _tipTitle = tipTitle;
    self.titleLabel.text = tipTitle;
    self.titleLabel.textColor = [UIColor lightGrayColor];
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview) {
        if (self.icon == nil) {
            self.icon = @"image_100x100";
        }
        if (self.tipTitle.length == 0) {
            self.tipTitle = @"没有相关数据";
        }
    }
    
}

-(void)layoutSubviews{
    [super  layoutSubviews];
    
}
@end
