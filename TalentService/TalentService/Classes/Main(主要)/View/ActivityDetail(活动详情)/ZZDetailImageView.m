//
//  ZZDetailImageView.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZDetailImageView.h"
#import "AdScrollView.h"

@interface ZZDetailImageView ()<UIAlertViewDelegate>

@end
@implementation ZZDetailImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        [self  setUpChild];
    }
    return self;
}
- (void)setUpChild{
    self.backgroundColor = [UIColor  whiteColor];
    //广告位
    CGFloat sx = 0;
    CGFloat sy = 0;
    CGFloat w = ScreenWidth;
    CGFloat h = w * 0.5;
    AdScrollView * scrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(sx, sy, w, h)];
    scrollView.scrollsToTop = NO;
    // ,@"weibo_50x50"
    scrollView.imageNameArray = @[@"QQ_50x50",@"Wechat_50x50",@"weibo_50x50"];
    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    [self addSubview:scrollView];
    //已参加  人数label
    CGFloat lx = 20;
    CGFloat ly = CGRectGetMaxY(scrollView.frame);
    CGFloat lw = 150;
    CGFloat lh = 40;
    UILabel *label = [[UILabel  alloc]initWithFrame:CGRectMake(lx, ly, lw, lh)];
    label.textColor = ZZLightGrayColor;
    label.font = ZZContentFont;
    label.text = @"已参加    30人";
    [self addSubview:label];
    
    // 报名按钮
    
    CGFloat by = ly + ZZEdgeMargin;
    CGFloat bw = 80;
    CGFloat bh = lh - 2*ZZEdgeMargin;
    
    CGFloat bx = ScreenWidth - bw - lx;
    UIButton *button = [[UIButton  alloc]initWithFrame:CGRectMake(bx, by, bw, bh)];
    [button  setTitle:@"预  订" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    [button  addTarget:self action:@selector(booking) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = ZZNatiBarColor;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [self  addSubview:button];
    
    self.totalHeight = CGRectGetMaxY(label.frame);
    
}

#pragma mark event response
- (void)booking{
    UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:@"你确定要报名这个活动嘛" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert  show];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ) {
        ZZLog(@"我要申请");
    }
}
@end
