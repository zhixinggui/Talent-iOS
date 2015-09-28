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

- (void)didClickOnCell:(ZZOrderCell *)orderCell andOrderStatus:(ZZOrderStatus)orderStatus;

@end

@interface ZZOrderCell : UITableViewCell
@property (nonatomic , strong) ZZOrder *order;
@property (nonatomic ,weak) id<ZZOrderCellDelegate>delegate;
@end
