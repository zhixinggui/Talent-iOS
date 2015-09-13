//
//  ZZApplyTalentParam.h
//  TalentService
//
//  Created by 张亮亮 on 15/9/11.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//申请达人

#import <Foundation/Foundation.h>

@interface ZZApplyTalentParam : NSObject
/**用户真实姓名*/
@property (nonatomic, copy)NSString *userName;
/**身份证号*/
@property (nonatomic, copy)NSString *identityCard;
/**手机号码*/
@property (nonatomic, copy)NSString *phone;
/**验证码*/
@property (nonatomic, copy)NSString *securityCode;
/**个人描述*/
@property (nonatomic, copy)NSString *userPresentation;
/**达人类型*/
@property (nonatomic, strong)NSNumber *eredarType;

@end
