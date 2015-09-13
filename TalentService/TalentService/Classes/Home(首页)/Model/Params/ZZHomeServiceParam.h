//
//  ZZHomeServiceParam.h
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZHomeServiceParam : NSObject
/** 是否推荐 1是 0否*/
@property (nonatomic, strong)NSNumber *isRecommoned;
/**每页显示条数*/
@property (nonatomic, strong)NSNumber *numberOfPerPage;
/**pageNo*/
@property (nonatomic, strong)NSNumber *pageNo;

@end
