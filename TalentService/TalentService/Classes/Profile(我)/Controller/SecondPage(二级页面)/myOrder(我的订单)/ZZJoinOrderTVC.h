//
//  ZZJoinOrderTVC.h
//  TalentService
//
//  Created by charles on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZMyJoinOrderVC.h"

@class ZZMyJoinOrderVC;
@interface ZZJoinOrderTVC : UITableViewController
@property (nonatomic) ZZOrderType orderType;
@property (nonatomic) NSInteger serviceId;
@property (nonatomic, weak)ZZMyJoinOrderVC *myJoinOrderVcDelegate;
@end
