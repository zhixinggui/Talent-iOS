//
//  ZZActivityListParam.h
//  TalentService
//
//  Created by 张亮亮 on 15/9/11.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZActivityListParam : NSObject
/** 是否推荐 1是 0否*/
@property (nonatomic, strong)NSNumber *isRecommoned;
/**每页显示条数*/
@property (nonatomic, strong)NSNumber *numberOfPerPage;
/**pageNo*/
@property (nonatomic, strong)NSNumber *pageNo;

/**市*/
@property (nonatomic, strong)NSNumber *city;

/** 类型*/
@property (nonatomic, strong)NSNumber *type;
/**状态*/
@property (nonatomic, strong)NSNumber *status;

@end
