//
//  ZZBaseOrderView.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZBaseOrderView.h"
#import "ZZActivity.h"
@implementation ZZBaseOrderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor  whiteColor];
    }
    return self;
}


- (void)setUpChild{
    
    ZZActivity *activity = self.order.serviceInfo;
    //标题
    CGFloat titleX = edge;
    CGFloat titleY = 20;
    CGFloat titleW = ScreenWidth - ZZEdgeMargin - space;
    CGFloat titleH = 40;
    UILabel *titleLabel = [[UILabel  alloc]initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
    titleLabel.numberOfLines = 2;
    titleLabel.text = activity.title;
    titleLabel.textColor = ZZDarkGrayColor;
    titleLabel.font = ZZTitleFont;
    [self  addSubview:titleLabel];
    
    //城市
    CGFloat contentX = titleX;
    CGFloat contentY = CGRectGetMaxY(titleLabel.frame) + 5;
    CGFloat contentW = titleW;
    CGFloat contentH = 20;
    UILabel *contentLabel = [[UILabel  alloc]initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
    contentLabel.text = activity.cityText;
    contentLabel.textColor = ZZDarkGrayColor;
    contentLabel.font = ZZTitleFont;
    [self  addSubview:contentLabel];
    
    //钱
    CGFloat moneyW = space - edge - edge;
    CGFloat moneyH = 20;
    CGFloat moneyX = ScreenWidth - moneyW - edge;
    CGFloat moneyY = CGRectGetMidY(titleLabel.frame);
  
    UILabel *moneyLabel = [[UILabel  alloc]initWithFrame:CGRectMake(moneyX, moneyY, moneyW, moneyH)];
   // moneyLabel.text =   [self.order showPrice:self.order.servicePrice];
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
    [self  setUpShowView:@"订单号：" content:self.order.orderCode];
     [self  setUpShowView:@"订单时间：" content:self.order.orderDate];
     [self  setUpShowView:@"用户名：" content:self.order.userNike];
  self.phoneShowView =   [self  setUpShowView:@"手机号：" content:self.order.phone];
     [self  setUpShowView:@"活动时间：" content:activity.startTime];
     [self  setUpShowView:@"活动地点：" content:activity.address];
   //  [self  setUpShowView:@"金额：" content:[self.order showPrice:self.order.price]];

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
