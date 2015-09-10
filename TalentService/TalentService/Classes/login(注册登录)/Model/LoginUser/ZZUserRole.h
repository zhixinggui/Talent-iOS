//
//  ZZUserRole.h
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZUserRole : NSObject
/** 更新日期*/
@property (nonatomic, copy)NSString *updateDate;
/** 达人名称*/
@property (nonatomic, copy)NSString *eredarName;
/** 创建日期*/
@property (nonatomic, copy)NSString *createDate;
/** 更新人ID*/
@property (nonatomic, assign)NSInteger updateUserId;
/** 大人编码*/
@property (nonatomic, assign)NSInteger eredarCode;
/** 创建人ID*/
@property (nonatomic, assign)NSInteger createUserId;
@end
