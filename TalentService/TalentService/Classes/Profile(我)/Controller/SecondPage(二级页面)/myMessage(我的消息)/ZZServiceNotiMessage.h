//
//  ZZServiceNotiMessage.h
//  TalentService
//
//  Created by charles on 15/10/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZServiceNotiMessage : NSObject
/**
 *推送内容
 */
@property (nonatomic, strong)NSString *alert;
/**
 *推送类型
 */
@property (nonatomic)NSInteger type;
/**
 *服务id
 */
@property (nonatomic)NSInteger relationId;
/**
 *服务订单号
 */
@property (nonatomic ,strong)NSString *orderCode;
@end
