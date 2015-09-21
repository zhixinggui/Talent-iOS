//
//  ZZBaseResult.h
//  TalentService
//
//  Created by charles on 15/9/21.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZBaseResult : NSObject
/** 页数  */
@property (nonatomic)NSInteger page;
/** 记录数  */
@property (nonatomic)NSInteger records;
/** 列表  */
@property (nonatomic, strong) NSArray *rows;
/** 总共多少  */
@property (nonatomic)NSInteger total;
@end
