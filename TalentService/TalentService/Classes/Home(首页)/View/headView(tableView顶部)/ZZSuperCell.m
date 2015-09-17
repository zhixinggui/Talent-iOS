//
//  ZZSuperCell.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSuperCell.h"
#import "ZZOtherUser.h"
#import "ZZHeadImageView.h"
@interface ZZSuperCell ()
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)ZZHeadImageView *headIV;
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

-(ZZHeadImageView *)headIV{
    if (_headIV == nil) {
        _headIV = [[ZZHeadImageView  alloc]init];
        _headIV.backgroundColor = [UIColor  yellowColor];
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
    
    //名字
    self.nameLabel.frame = CGRectMake(0, height- 20, width, nameH);
//    self.nameLabel.text = @"达人";
}

-(void)setOtherUser:(ZZOtherUser *)otherUser{
    _otherUser = otherUser;
    [self.headIV  setHeadImageWithURL:otherUser.userSmallImg];
    self.nameLabel.text = otherUser.userNike;
}
@end
