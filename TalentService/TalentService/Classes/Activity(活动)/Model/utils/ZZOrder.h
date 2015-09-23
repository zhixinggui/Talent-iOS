//
//  ZZOrder.h
//  TalentService
//
//  Created by zhizhen on 15/9/22.
//  Copyright © 2015年 zhizhen. All rights reserved.
// 订单

#import <Foundation/Foundation.h>

@interface ZZOrder : NSObject
/**是否出具发票*/
@property (nonatomic) BOOL isInvoice;
/**订单状态*/
@property (nonatomic) NSInteger status;
/**是否使用金币*/
@property (nonatomic) BOOL isGold;
/**服务id*/
@property (nonatomic) NSInteger serviceId;
/**金币数量*/
@property (nonatomic) NSInteger goldCount;
/**订单号*/
@property (nonatomic) NSInteger orderCode;
/**支付方式*/
@property (nonatomic) NSInteger payment;
/**用户昵称*/
@property (nonatomic, copy)NSString *userNike;
/**订单日期*/
@property (nonatomic, copy)NSString *orderDate;
/**发票抬头*/
@property (nonatomic, copy)NSString *invoiceTitle;
/**用户id*/
@property (nonatomic) NSUInteger userId;


/**服务价格*/
@property (nonatomic) NSInteger servicePrice;
/**金币换算金额*/
@property (nonatomic) NSInteger discountPrice;
/**价格*/
@property (nonatomic) NSInteger price;


@end
