//
//  ZZPayTypeShowView.h
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZPayType.h"
@interface ZZPayTypeShowView : UIView
@property (nonatomic, strong)ZZPayType *payType;
@property (nonatomic) BOOL  selected;

- (void)addTarget:(id)target action:(SEL)action;

+ (instancetype)payTypeShowView;
@end
