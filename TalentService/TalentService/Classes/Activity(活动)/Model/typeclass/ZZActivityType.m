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
    
    for (int i = 0; i < 4; i++) {
        ZZActivityType *type = [[ZZActivityType  alloc]init];
        switch (i) {
            case 0:
                type.typeName = @"全部";
            
                break;
            case 1:
                type.typeName = @"催乳师培训";
                type.typeNumber = 1;
                break;
            case 2:
                type.typeName = @"亲子手工";
                type.typeNumber = 2;
                break;
            case 3:
                type.typeName = @"营养餐制作";
                type.typeNumber = 3;
                break;
    
        }
        [array  addObject:type];
    }
    return array;
}
@end
