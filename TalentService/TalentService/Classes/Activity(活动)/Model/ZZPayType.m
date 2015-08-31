//
//  ZZPayType.m
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZPayType.h"

@implementation ZZPayType
- (instancetype)initWithPayTypeForm:(ZZPayTypeForm )payTypeForm iconName:(NSString *)iconName name:(NSString *)name{
    self = [super init];
    if (self) {
        self.payTypeForm = payTypeForm;
        self.iconName = iconName;
        self.name = name;
    }
    return self;
}
@end
