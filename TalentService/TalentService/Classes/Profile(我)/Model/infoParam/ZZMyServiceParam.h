//
//  ZZMyServiceParam.h
//  TalentService
//
//  Created by charles on 15/9/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZParam.h"

@interface ZZMyServiceParam : ZZParam
/**
 *  1 个人主页  2 我的页面
 */
@property(nonatomic, strong)NSNumber *myCenter;
/**
 *  1 达人 0  普通用户 是否是达人
 */
@property(nonatomic, strong)NSNumber *isEredar;
/**
 * 用户ID  myCenter为1时可不传，否则须传入用户ID
 */
@property(nonatomic, strong)NSNumber *userId;

/**
 *页数
 */
@property (nonatomic, strong)NSNumber *numberOfPerPage;

/**
 *第几页
 */
@property (nonatomic, strong)NSNumber *pageNo;

@end
