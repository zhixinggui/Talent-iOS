//
//  ZZBaseOrderView.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZBaseOrderView.h"

@implementation ZZBaseOrderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor  whiteColor];
        [self  setUpChild];
        
    }
    return self;
}
- (void)setUpChild{
    
    //标题
    CGFloat titleX = edge;
    CGFloat titleY = 20;
    CGFloat titleW = ScreenWidth - ZZEdgeMargin - space;
    CGFloat titleH = 40;
    UILabel *titleLabel = [[UILabel  alloc]initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
    titleLabel.numberOfLines = 2;
    titleLabel.text = @"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十";
    titleLabel.textColor = ZZDarkGrayColor;
    titleLabel.font = ZZTitleFont;
    [self  addSubview:titleLabel];
    
    //城市
    CGFloat contentX = titleX;
    CGFloat contentY = CGRectGetMaxY(titleLabel.frame) + 5;
    CGFloat contentW = titleW;
    CGFloat contentH = 20;
    UILabel *contentLabel = [[UILabel  alloc]initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
    contentLabel.text = @"城市";
    contentLabel.textColor = ZZDarkGrayColor;
    contentLabel.font = ZZTitleFont;
    [self  addSubview:contentLabel];
    
    //钱
    CGFloat moneyW = space - edge - edge;
    CGFloat moneyH = 20;
    CGFloat moneyX = ScreenWidth - moneyW - edge;
    CGFloat moneyY = CGRectGetMidY(titleLabel.frame);
  
    UILabel *moneyLabel = [[UILabel  alloc]initWithFrame:CGRectMake(moneyX, moneyY, moneyW, moneyH)];
    moneyLabel.text = @"城市";
    moneyLabel.textColor = ZZNatiBarColor;
    moneyLabel.font = ZZTitleFont;
    [self  addSubview:moneyLabel];
    
    //钱
    CGFloat lineW = ScreenWidth;
    CGFloat lineH = 1;
    CGFloat lineX = 0;
    CGFloat lineY = CGRectGetMidY(contentLabel.frame) + titleY;
    
    UILabel *lineLabel = [[UILabel  alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];

    lineLabel.backgroundColor = ZZSeparGrayColor;
    [self  addSubview:lineLabel];
    
    self.toalheight = CGRectGetMaxY(lineLabel.frame);
    [self  setUpShowView:@"订单号：" content:@"201507200001"];
     [self  setUpShowView:@"订单时间：" content:@"2015-07-20 12:00"];
     [self  setUpShowView:@"用户名：" content:@"一二三四五六七"];
  self.phoneShowView =   [self  setUpShowView:@"手机号：" content:@"15821565760"];
     [self  setUpShowView:@"活动时间：" content:@"2015-07-22 12:00"];
     [self  setUpShowView:@"活动地点：" content:@"一二三四五六七一二三四五六七一二三四五六七一二三四五六七一二三四五六七一二三四五六七"];
     [self  setUpShowView:@"金额：" content:@"10元"];

    self.contentSize = CGSizeMake(0, self.toalheight);
}

- (ZZOrderInfoShowView *)setUpShowView:(NSString *)title content:(NSString *)content{
    ZZOrderInfoShowView *showView = [[ZZOrderInfoShowView alloc]initWithFrame:CGRectMake(0, self.toalheight, ScreenWidth, 50)];
    [showView setTitle:title content:content];
    self.toalheight = CGRectGetMaxY(showView.frame);
    [self  addSubview:showView];
    
    return showView;
}
@end
