//
//  ZZEnsureOrderController.h
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
// 确认订单

#import <UIKit/UIKit.h>
#import "ZZOrder.h"
@class ZZActivity;
@interface ZZEnsureOrderController : UIViewController
@property (nonatomic ,strong)ZZOrder *order;
@property (nonatomic, strong)ZZActivity *activity;
@end
