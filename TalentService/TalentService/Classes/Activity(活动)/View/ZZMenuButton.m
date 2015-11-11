//
//  ZZMenuButton.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMenuButton.h"

@implementation ZZMenuButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor  whiteColor];
        [self setTitleColor:ZZLightGrayColor forState:UIControlStateNormal];
        [self  setTitleColor:ZZGreenColor forState:UIControlStateSelected];
        self.titleLabel.font = ZZContentFont;
        [self  setImage:[UIImage  imageNamed:@"down_20x20"] forState:UIControlStateNormal];
        [self  setImage:[UIImage  imageNamed:@"down_selected_20x20"] forState:UIControlStateSelected];
    }
    return self;
}

-(void)awakeFromNib{
    self.backgroundColor = [UIColor  whiteColor];
    [self setTitleColor:ZZLightGrayColor forState:UIControlStateNormal];
    [self  setTitleColor:ZZGreenColor forState:UIControlStateSelected];
    self.titleLabel.font = ZZContentFont;
    [self  setImage:[UIImage  imageNamed:@"down_20x20"] forState:UIControlStateNormal];
    [self  setImage:[UIImage  imageNamed:@"down_selected_20x20"] forState:UIControlStateSelected];
}

-(void)setFrame:(CGRect)frame{
    [super  setFrame:frame];
    [self  setNeedsLayout];
}
-(void)layoutSubviews{
    [super  layoutSubviews];
        // 1.计算titleLabel的frame
        self.titleLabel.x = self.imageView.x;
        
        // 2.计算imageView的frame
        self.imageView.x = self.width - 5 -self.imageView.width;
}

@end
