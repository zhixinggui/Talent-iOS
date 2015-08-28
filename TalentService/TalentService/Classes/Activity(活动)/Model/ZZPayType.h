//
//  ZZPayType.h
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
// 支付方式

#import <Foundation/Foundation.h>
typedef enum {
    ZZPayTypeFormZhiFuBao = 1 //支付宝
}ZZPayTypeForm;
@interface ZZPayType : NSObject

@property (nonatomic) ZZPayTypeForm payTypeForm;
@property (nonatomic, copy)NSString *iconName;
@property (nonatomic, copy)NSString *name;

- (instancetype)initWithPayTypeForm:(ZZPayTypeForm )payTypeForm iconName:(NSString *)iconName name:(NSString *)name;
@end
