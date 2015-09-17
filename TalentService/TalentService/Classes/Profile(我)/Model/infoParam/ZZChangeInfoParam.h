//
//  ZZChangeInfoParam.h
//  TalentService
//
//  Created by charles on 15/9/15.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZParam.h"

@interface ZZChangeInfoParam : NSObject
/**
 *  头像图片路径
 */
@property (nonatomic,copy)NSString *imgPath;
/**
 *  用户昵称
 */
@property (nonatomic,copy)NSString *userNike;
/**
 *  手机号码
 */
@property (nonatomic,copy)NSString *userPhone;
/**
 *  省
 */
@property (nonatomic,strong)NSNumber *province;
/**
 *  区
 */
@property (nonatomic,strong)NSNumber *district;
/**
 *  市
 */
@property (nonatomic,strong)NSNumber *city;
/**
 *  详细地址
 */
@property (nonatomic,copy)NSString *userAddress;
/**
 *  性别:1男  2女
 */
@property (nonatomic,strong)NSNumber *userSex;

@end
