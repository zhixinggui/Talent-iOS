//
//  ZZCollectParam.h
//  TalentService
//
//  Created by charles on 15/9/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZParam.h"

@interface ZZCollectParam : ZZParam
/**
 *页数
 */
@property (nonatomic ,strong)NSNumber *pageNo;
/**
 *个数
 */
@property (nonatomic ,strong)NSNumber *numberOfPerPage;
@end
