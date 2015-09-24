//
//  ZZEnsureOrderView.h
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZBaseOrderView.h"
@class ZZEnsureOrderController;
@interface ZZEnsureOrderView : ZZBaseOrderView
@property (nonatomic, weak) ZZEnsureOrderController  *delegateVC;
@end
