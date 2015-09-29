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
    for (int i = 0; i < 4; i++) {
        ZZActivityStatus *status = [[ZZActivityStatus  alloc]init];
        switch (i) {
            case 0:
                status.statusName = @"全部状态";
                status.statusNumber = ZZActivityStatusTypeAll;
                 break;
            case 1:
             status.statusName = @"未开始";
                status.statusNumber = ZZActivityStatusTypeNoStart;
                break;
            case 2:
                status.statusName = @"已开始";
                status.statusNumber = ZZActivityStatusTypeDidStart;
                break;
            case 3:
                status.statusName = @"已结束";
                status.statusNumber = ZZActivityStatusTypeDidEnd;
                break;
       
        }
        [array  addObject:status];
    }
    return array;
}
@end
