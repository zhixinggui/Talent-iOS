//
//  ZZAlipayTool.h
//  TalentService
//
//  Created by charles on 15/10/21.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZOrder.h"
@interface ZZAlipayTool : NSObject
//支付宝
+ (void)aliPayForOrderWithOrderDetail:(ZZOrder *)orderDetail andPaymentData:(NSString *)paymentData;
@end
