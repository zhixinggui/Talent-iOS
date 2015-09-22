//
//  ZZDetailImageView.h
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZActivityDetailController,ZZActivity;

@interface ZZDetailImageView : UIView

@property (nonatomic, weak)ZZActivityDetailController *delegateVC;
@property (nonatomic)CGFloat totalHeight;
@property (nonatomic, weak)ZZActivity *activity;
@end
