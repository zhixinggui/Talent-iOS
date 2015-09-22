//
//  ZZHeadImageView.m
//  TalentService
//
//  Created by zhizhen on 15/9/14.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZHeadImageView.h"


@implementation ZZHeadImageView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor  lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5;
        
    }
    
    return self;
}

-(void)awakeFromNib{
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor  lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
}
-(void)layoutSubviews{
    [super  layoutSubviews];
    ZZLog(@",,%f,,%f",self.height,self.width);
    self.layer.cornerRadius = MAX(self.height, self.width)/2;
}


@end
