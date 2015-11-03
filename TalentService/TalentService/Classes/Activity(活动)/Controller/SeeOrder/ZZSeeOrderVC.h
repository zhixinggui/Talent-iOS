//
//  ZZSeeOrderVC.h
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZSeeOrderVC : UIViewController
/**
 *判断是哪个界面跳转过来 0 流程界面 1订单列表
 */
@property (nonatomic)NSInteger isDetail;

@property (nonatomic, copy)NSString *orderCode;

@end
