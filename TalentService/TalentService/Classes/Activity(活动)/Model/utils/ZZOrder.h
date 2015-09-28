//
//  ZZOrder.h
//  TalentService
//
//  Created by zhizhen on 15/9/22.
//  Copyright © 2015年 zhizhen. All rights reserved.
// 订单

#import <Foundation/Foundation.h>
#import "ZZActivity.h"
@interface ZZOrder : NSObject
/**是否出具发票*/
@property (nonatomic) BOOL isInvoice;
/**服务标题*/
@property (nonatomic, copy)NSString *title;
/**订单状态*/
@property (nonatomic) ZZOrderStatus status;
/**是否使用金币*/
@property (nonatomic) BOOL isGold;
/**订单id*/
@property (nonatomic) NSInteger orderId;
/**服务id*/
@property (nonatomic) NSInteger serviceId;
/**金币数量*/
@property (nonatomic) NSInteger goldCount;
/**订单号*/
@property (nonatomic ,copy) NSString *orderCode;
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
/**电话*/
@property (nonatomic, copy)NSString *phone;
/**服务图片*/
@property (nonatomic, copy)NSString *servicesImg;

@property (nonatomic, strong)ZZActivity *serviceBasicInfo;
/**服务价格*/
@property (nonatomic, strong) NSNumber *servicePrice;
/**金币换算金额*/
@property (nonatomic, strong) NSNumber *discountPrice;
/**价格*/
@property (nonatomic, strong) NSNumber *price;

- (NSString *)showPrice:(NSNumber *)price;
@end
