//
//  ZZDetailFunctionView.h
//  TalentService
//
//  Created by zhizhen on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZDetailFunctionView;
@protocol ZZDetailFunctionViewDelegate <NSObject>
/** 分享数组选中了数组中的那个元素 */
- (void)detailFunctionView:(ZZDetailFunctionView *)detaileFunctionView shares:(NSArray *)shares  selectedAtIndex:(NSUInteger )index;
/** 功能数组选中了数组中的那个元素 */
- (void)detailFunctionView:(ZZDetailFunctionView *)detaileFunctionView functions:(NSArray *)functions   selectedAtIndex:(NSUInteger )index;

@end
@interface ZZDetailFunctionView : UIView
/** 只能通过这个方法创建 */
+ (instancetype)detailFunctionView ;
/** 分享到显示的数组，数组中的元素遵守ZZFunctionShowRuleDelegate */
@property (nonatomic, strong)NSArray  * shares;

/** 功能按钮的数组，数组中的元素遵守ZZFunctionShowRuleDelegate */
@property (nonatomic, strong)NSArray  * functions;

@property (nonatomic, weak) id<ZZDetailFunctionViewDelegate>  delegate;
/** 显示动画 */
- (void)showAnimation;

/** 消失动画 */
- (void)dismissAnimation;
@end
