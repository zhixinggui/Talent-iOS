//
//  ZZEnsureOrderController.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZEnsureOrderController.h"
#import "ZZEnsureOrderView.h"
#import "ZZSelectPayTypeVC.h"
@interface ZZEnsureOrderController ()<ZZBaseOrderViewDelegate>

@end

@implementation ZZEnsureOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    self.view.backgroundColor = ZZViewBackColor;
    [self  setUpChild];
    
}


- (void)setUpChild{
    ZZEnsureOrderView *ensuewView =[[ ZZEnsureOrderView alloc]initWithFrame:self.view.bounds];
    ensuewView .delegate = self;
    [self.view  addSubview:ensuewView];
}

#pragma mark -ZZBaseOrderViewDelegate
- (void)baseOrderViewEnsueOrder:(ZZBaseOrderView *)baseprderView{
    ZZSelectPayTypeVC *selectPayTypeVC = [[ZZSelectPayTypeVC  alloc]init];
    [self.navigationController  pushViewController:selectPayTypeVC animated:YES];
}
@end
