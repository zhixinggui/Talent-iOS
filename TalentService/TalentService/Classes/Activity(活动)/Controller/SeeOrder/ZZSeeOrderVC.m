//
//  ZZSeeOrderVC.m
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSeeOrderVC.h"
#import "ZZSeeOrderView.h"
#import "ZZCancelOrderVC.h"
#import "ZZActivityHttpTool.h"
@interface ZZSeeOrderVC ()<ZZBaseOrderViewDelegate>

@end

@implementation ZZSeeOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看订单";
    self.view.backgroundColor = ZZViewBackColor;
    [self  getOrderDetail];
    [self  setUpChild];
    
}


- (void)setUpChild{
    ZZSeeOrderView *seeOrderView =[[ ZZSeeOrderView alloc]initWithFrame:self.view.bounds];
    seeOrderView .delegate = self;
    [self.view  addSubview:seeOrderView];
}

- (void)getOrderDetail{
    
    [ZZActivityHttpTool  activitySeeOrder:self.orderCode success:^(id json, ZZNetDataType netDataType) {
        
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        
    }];
}
#pragma mark -ZZBaseOrderViewDelegate
-(void)baseOrderViewCancellOrder:(ZZBaseOrderView *)baseprderView{
    ZZLog(@"取消订单");
    ZZCancelOrderVC *cancelOrderVc = [[ZZCancelOrderVC alloc]initWithNib];
    [self.navigationController pushViewController:cancelOrderVc animated:YES];
}

@end
