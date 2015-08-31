//
//  ZZSeeOrderView.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSeeOrderView.h"

@implementation ZZSeeOrderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        [self  setUpChild];
    }
    return self;
}
- (void)setUpChild{
    [super  setUpChild];
    [self setUpShowView:@"订单状态：" content:@"已支付"];
    
    UIButton *cancell = [[UIButton  alloc]initWithFrame:CGRectMake(edge,edge+self.toalheight, ScreenWidth - 2*edge, 40)];
    cancell.backgroundColor = ZZNatiBarColor;
    cancell.layer.cornerRadius = 20;
    cancell.layer.masksToBounds = YES;
    
    [cancell  setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancell  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    [cancell  addTarget:self action:@selector(cancellPhone) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:cancell];
    
    self.toalheight = CGRectGetMaxY(cancell.frame)+edge;
    
    self.contentSize = CGSizeMake(0, self.toalheight);
}

- (void)cancellPhone{
    if ([self.delegate  respondsToSelector:@selector(baseOrderViewCancellOrder:)]) {
        [self.delegate  baseOrderViewCancellOrder:self];
    }
}

@end
