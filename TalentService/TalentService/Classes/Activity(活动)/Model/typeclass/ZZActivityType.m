//
//  ZZActivityType.m
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityType.h"

@implementation ZZActivityType
//显示的文字
- (NSString *)content{
    return self.typeName;
}
+ (NSArray *)arrays{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        ZZActivityType *city = [[ZZActivityType  alloc]init];
        city.typeName = [ NSString  stringWithFormat:@"类型%d",i];
        [array  addObject:city];
    }
    return array;
}
@end
