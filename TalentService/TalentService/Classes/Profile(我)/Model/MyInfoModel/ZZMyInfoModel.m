//
//  ZZMyInfoModel.m
//  TalentService
//
//  Created by zhizhen on 15/9/24.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZMyInfoModel.h"

@implementation ZZMyInfoModel
- (instancetype)initWithText:(NSString *)text iconName:(NSString *)iconName classType:(Class)classType{
    self = [super init];
    if (self) {
        self.text = text;
        self.iconName = iconName;
        self.classType = classType;
    }
    return self;
}
+ (instancetype)myInfoModelWithText:(NSString *)text iconName:(NSString *)iconName classType:(Class)classType{
    return [[self  alloc]initWithText:text iconName:iconName classType:classType];
}
@end
