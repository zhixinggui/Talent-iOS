//
//  ZZCounty.h
//  TalentService
//
//  Created by zhizhen on 15/9/8.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZCounty : NSObject
@property (nonatomic, assign)NSUInteger countyId;
@property (nonatomic) NSUInteger code;
@property (nonatomic) NSUInteger pid;
@property (nonatomic) NSUInteger level;
@property (nonatomic, copy)NSString *name;
@end
