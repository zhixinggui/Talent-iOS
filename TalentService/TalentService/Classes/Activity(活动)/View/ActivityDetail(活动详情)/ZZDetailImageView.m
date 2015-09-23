//
//  ZZDetailImageView.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZDetailImageView.h"
#import "AdScrollView.h"
#import "ZZActivity.h"
#import "ZZActivityDetailController.h"
@interface ZZDetailImageView ()<UIAlertViewDelegate>

@end
@implementation ZZDetailImageView


-(void)setActivity:(ZZActivity *)activity{
    _activity = activity;
    [self  setUpChild];
}
- (void)setUpChild{
    self.backgroundColor = [UIColor  whiteColor];
    //广告位
    CGFloat sx = 0;
    CGFloat sy = 0;
    CGFloat w = ScreenWidth;
    CGFloat h = w * 0.5;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(sx, sy, w, h)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView  setPictureImageWithURL:self.activity.servicesImg];
    imageView.userInteractionEnabled = YES;
    [imageView  addTarget:self action:@selector(showBigImage)];
    [self addSubview:imageView];
    //已参加  人数label
    CGFloat lx = 20;
    CGFloat ly = CGRectGetMaxY(imageView.frame);
    CGFloat lw = 150;
    CGFloat lh = 40;
    UILabel *label = [[UILabel  alloc]initWithFrame:CGRectMake(lx, ly, lw, lh)];
    label.textColor = ZZLightGrayColor;
    label.font = ZZContentFont;
    label.text = [NSString  stringWithFormat:@"已参加  %ld/%ld",self.activity.realityPeoples,self.activity.peoples];
    [self addSubview:label];
    
    //已参加  人数label
  
    CGFloat py = CGRectGetMaxY(imageView.frame);
    CGFloat pw = 40;
    CGFloat ph = 40;
      CGFloat px = w - pw -20;
    UILabel *priceLabel = [[UILabel  alloc]initWithFrame:CGRectMake(px, py, pw, ph)];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.textColor = ZZLightGrayColor;
    priceLabel.font = ZZContentFont;
    priceLabel.text = self.activity.price;;
    [self addSubview:priceLabel];
    self.totalHeight = CGRectGetMaxY(label.frame);
}
#pragma mark 查看大图
- (void)showBigImage{
    [self.delegateVC  showBigImage:NO currentpage:0];
}
@end
