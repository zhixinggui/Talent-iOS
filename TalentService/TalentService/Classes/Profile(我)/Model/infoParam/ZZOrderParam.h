//
//  ZZOrderParam.h
//  TalentService
//
//  Created by charles on 15/9/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZParam.h"

@interface ZZOrderParam : ZZParam
/**
 *1 我的接单 0我的订单
 */
@property (nonatomic ,strong)NSNumber *queryType;
/**
 *页数
 */
@property (nonatomic ,strong)NSNumber *pageNo;
/**
 *个数
 */
@property (nonatomic ,strong)NSNumber *numberOfPerPage;
/**
 *服务状态
 */
@property (nonatomic ,strong)NSString *status;
/**
 *服务主键id
 */
@property (nonatomic, strong)NSNumber *serviceId;

@end
