//
//  ZZActivityStatus.m
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityStatus.h"

@implementation ZZActivityStatus
//显示的文字
- (NSString *)content{
    return self.statusName;
}
+ (NSArray *)arrays{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        ZZActivityStatus *city = [[ZZActivityStatus  alloc]init];
        city.statusName = [ NSString  stringWithFormat:@"北京%d",i];
        [array  addObject:city];
    }
    return array;
}
@end
