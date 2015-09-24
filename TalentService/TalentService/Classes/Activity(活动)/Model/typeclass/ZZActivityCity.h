//
//  ZZActivityCity.h
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZFunctionShowRule.h"
@interface ZZActivityCity : NSObject<ZZSelectorViewShowDele>
@property (nonatomic, copy)NSString *cityName;

+ (NSArray *)arrays;
@end
