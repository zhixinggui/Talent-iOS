//
//  ZZInfoParam.h
//  TalentService
//
//  Created by charles on 15/9/15.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZParam.h"

@interface ZZInfoParam : ZZParam
/**
 *  被关注人Id(用于个人主页)
 */
@property(nonatomic, strong)NSNumber *userAttentionId;
/**
 *  1 个人主页  2 我的页面
 */
@property(nonatomic, strong)NSNumber *myCenter;
@end
