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
@interface ZZEnsureOrderController ()

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
    ensuewView.order = self.order;
    ensuewView.delegateVC = self;
    [ensuewView  setUpChild];
    [self.view  addSubview:ensuewView];
}


@end
