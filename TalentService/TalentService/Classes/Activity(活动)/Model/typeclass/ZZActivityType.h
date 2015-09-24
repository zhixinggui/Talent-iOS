//
//  ZZActivityType.h
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZFunctionShowRule.h"
@interface ZZActivityType : NSObject<ZZSelectorViewShowDele>
@property (nonatomic, copy)NSString *typeName;
+ (NSArray *)arrays;
@end
