//
//  ZZActivityConmitParam.h
//  TalentService
//
//  Created by zhizhen on 15/9/23.
//  Copyright © 2015年 zhizhen. All rights reserved.
//提交订单

#import <Foundation/Foundation.h>

@interface ZZActivityConmitParam : NSObject
/**订单号*/
@property (nonatomic, copy)NSString *orderCode;
/**电话*/
@property (nonatomic, copy)NSString *phone;
/**服务主键id*/
@property (nonatomic, strong)NSNumber *serviceId;
/**服务价格*/
@property (nonatomic, strong)NSNumber *servicePrice;
@end
