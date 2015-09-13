//
//  ZZBaseOrderView.h
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//
#define space  100
#define edge  30
#import <UIKit/UIKit.h>
#import "ZZOrderInfoShowView.h"
@class ZZBaseOrderView;

@protocol ZZBaseOrderViewDelegate <UIScrollViewDelegate>

@optional
- (void)baseOrderViewChangePhone:(ZZBaseOrderView *)baseprderView;

- (void)baseOrderViewCancellOrder:(ZZBaseOrderView *)baseprderView;
- (void)baseOrderViewEnsueOrder:(ZZBaseOrderView *)baseprderView;
@end

@interface ZZBaseOrderView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic) CGFloat  toalheight;

@property (nonatomic, strong) ZZOrderInfoShowView*  phoneShowView;

@property (nonatomic, weak)id<ZZBaseOrderViewDelegate> delegate;
- (void)setUpChild;
/**
 *  创建视图，并自动计算frame、添加到当前视图中
 *
 *  @param title   <#title description#>
 *  @param content <#content description#>
 *
 *  @return <#return value description#>
 */
- (ZZOrderInfoShowView *)setUpShowView:(NSString *)title content:(NSString *)content;
@end
