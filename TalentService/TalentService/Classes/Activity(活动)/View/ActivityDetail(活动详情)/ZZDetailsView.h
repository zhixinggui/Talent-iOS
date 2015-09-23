//
//  ZZDetailsView.h
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZActivityDetailController,ZZActivity;

@interface ZZDetailsView : UIView
@property (nonatomic, weak)ZZActivity *activity;
@property (nonatomic)CGFloat totalHeight;
@property (nonatomic, weak)ZZActivityDetailController *delegateVC;
@end
