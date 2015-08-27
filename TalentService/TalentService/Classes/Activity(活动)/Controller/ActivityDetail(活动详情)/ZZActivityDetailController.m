//
//  ZZActivityDetailController.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityDetailController.h"
#import "ZZDetailImageView.h"
#import "ZZDetailRuleView.h"
#import "ZZDetailsView.h"
#import "ZZActivityBottomToolBar.h"
#import "ZZEnsureOrderController.h"
@interface ZZActivityDetailController ()<ZZDetailImageViewDelegate>

@end

@implementation ZZActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    self.view.backgroundColor = ZZViewBackColor;
    [self  setUpChild];
}


- (void)setUpChild{
    CGFloat toolHeight = 49;
    
    CGFloat scrollWidth = self.view.bounds.size.width;
    CGFloat scrollHeight = self.view.bounds.size.height - toolHeight;
    UIScrollView *scrollView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
    [self.view  addSubview:scrollView];
    //广告位滚动图片
    ZZDetailImageView *detailIV = [[ZZDetailImageView  alloc]init];
    detailIV.delegate = self;
    detailIV.frame = CGRectMake(0, 0, ScreenWidth, detailIV.totalHeight);
    [scrollView addSubview:detailIV];
    //细则
    ZZDetailRuleView *detailRuleV = [[ZZDetailRuleView  alloc]init];
    detailRuleV.frame = CGRectMake(0, CGRectGetMaxY(detailIV.frame), ScreenWidth, detailRuleV.totalHeight);
    [scrollView addSubview:detailRuleV];
    //详情
    ZZDetailsView *detailView = [[ZZDetailsView  alloc]init];
    detailView.frame = CGRectMake(0, CGRectGetMaxY(detailRuleV.frame), ScreenWidth, detailView.totalHeight);
    [scrollView addSubview:detailView];
    
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(detailView.frame));
    //工具栏
    ZZActivityBottomToolBar *actiBottomTool = [[ZZActivityBottomToolBar  alloc]initWithFrame:CGRectMake(0, scrollHeight, scrollWidth, toolHeight)];
    [self.view  addSubview:actiBottomTool];
}

#pragma mark -ZZDetailImageViewDelegate
- (void)detailImageViewBooking:(ZZDetailImageView *)detalImageViewDelegate{
    ZZEnsureOrderController *ensureOC = [[ZZEnsureOrderController  alloc]init];
    [self.navigationController  pushViewController:ensureOC animated:YES];
}
@end
