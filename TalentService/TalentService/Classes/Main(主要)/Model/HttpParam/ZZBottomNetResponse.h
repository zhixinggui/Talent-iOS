//
//  ZZBottomNetResponse.h
//  TalentService
//
//  Created by charles on 15/10/26.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZBottomNetResponse : NSObject

@property (nonatomic ,strong)NSString *msg;

@property (nonatomic ,strong)id data;

@property (nonatomic)NSInteger orderId;
/**
 *支付种类
 */
@property (nonatomic ,strong)NSArray *payTypes;

@property (nonatomic )NSInteger status;

@end
