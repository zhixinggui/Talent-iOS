//
//  ZZTopicParam.h
//  TalentService
//
//  Created by charles on 15/11/11.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZParam.h"

@interface ZZTopicParam : ZZParam
/**
 *话题类型
 */
@property (nonatomic ,strong)NSString *topicType;
/**
 *页数
 */
@property (nonatomic ,strong)NSNumber *pageNo;
/**
 *个数
 */
@property (nonatomic ,strong)NSNumber *numberOfPerPage;
@end
