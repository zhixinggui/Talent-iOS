//
//  ZZTestOrderParam.h
//  TalentService
//
//  Created by charles on 15/9/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZParam.h"

@interface ZZTestOrderParam : ZZParam
/**
 *订单号
 */
@property (nonatomic ,strong)NSString *ordercode;
/**
 *服务主键id
 */
@property (nonatomic, strong)NSNumber *serviceId;
@end
