//
//  ZZMyOrderTVC.h
//  TalentService
//
//  Created by charles on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZMyOrderVC.h"
@class ZZMyOrderVC;
@interface ZZMyOrderTVC : UITableViewController
@property (nonatomic) ZZOrderType orderType;
@property (nonatomic , weak)ZZMyOrderVC *myOrderVcDelegate;
@end
