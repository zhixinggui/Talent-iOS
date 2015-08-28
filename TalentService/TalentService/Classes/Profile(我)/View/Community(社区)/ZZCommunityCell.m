//
//  ZZCommunityCell.m
//  TalentService
//
//  Created by charles on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZCommunityCell.h"
@interface ZZCommunityCell()

@end
@implementation ZZCommunityCell
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"border_43x47"]];
        [self setBackgroundView:imageView];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
