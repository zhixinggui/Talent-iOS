//
//  ZZAlipayOrderResult.h
//  TalentService
//
//  Created by charles on 15/10/27.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZAlipayOrderResult : NSObject
/**
 *支付方式Id
 */
@property (nonatomic)NSInteger paymentTypeId;
/**
 *支付方式名字
 */
@property (nonatomic ,strong)NSString *name;
/**
 *支付方式密钥
 */
@property (nonatomic ,strong)NSString *paymentData;
@end
