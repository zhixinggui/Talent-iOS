//
//  ZZOrderCell.h
//  TalentService
//
//  Created by charles on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZOrder.h"
#define orderCelldentifier @"orderCelldentifier"
@class ZZOrderCell;

@protocol ZZOrderCellDelegate <NSObject>
/**orderStatus 为0时立即支付，为ZZOrderStatusNotPaid时取消订单*/
- (void)didClickOnCell:(ZZOrderCell *)orderCell order:(ZZOrder *)order  orderStatus:(NSInteger)orderStatus;

@end

@interface ZZOrderCell : UITableViewCell
@property (nonatomic , strong) ZZOrder *order;
@property (nonatomic ,weak) id<ZZOrderCellDelegate>delegate;
@end
