//
//  ZZEmptyView.h
//  TalentService
//
//  Created by zhizhen on 15/9/28.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZEmptyView : UIView
+ (instancetype)emptyView;

@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *tipTitle;

@end
