//
//  ZZSuperCell.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSuperCell.h"

@interface ZZSuperCell ()
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *headIV;
@end
@implementation ZZSuperCell


-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel  alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = ZZNameFont;
        _nameLabel.textColor = ZZLightGrayColor;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UIImageView *)headIV{
    if (_headIV == nil) {
        _headIV = [[UIImageView  alloc]init];
        _headIV.contentMode = UIViewContentModeScaleAspectFill;
        _headIV.clipsToBounds = YES;
        _headIV.layer.masksToBounds = YES;
        [self.contentView  addSubview:_headIV];
    }
    return _headIV;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat nameH = 20;
    //头像
    CGFloat  headW = MIN(width, height-20);
    CGFloat  headX = (width -headW)/2;
    CGFloat  headY = (height-20 - headW)/2;
    self.headIV.frame = CGRectMake(headX, headY, headW, headW);
    self.headIV.layer.cornerRadius = headW/2;
    self.headIV.backgroundColor = [UIColor  yellowColor];
    
    //名字
    self.nameLabel.frame = CGRectMake(0, height- 20, width, nameH);
    self.nameLabel.text = @"达人";
}
@end
