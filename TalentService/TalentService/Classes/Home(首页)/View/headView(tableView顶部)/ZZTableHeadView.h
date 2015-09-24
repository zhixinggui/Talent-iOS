//
//  ZZTableHeadView.h
//  TalentService
//
//  Created by zhizhen on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZHomeViewController;
@interface ZZTableHeadView : UIView

@property (nonatomic, strong)NSArray *images;

@property (nonatomic, strong)NSArray *talents;

@property (nonatomic, weak)ZZHomeViewController *delegateVC;
@end
