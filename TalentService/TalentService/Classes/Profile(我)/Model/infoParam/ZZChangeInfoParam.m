//
//  ZZChangeInfoParam.m
//  TalentService
//
//  Created by charles on 15/9/15.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZChangeInfoParam.h"

@implementation ZZChangeInfoParam
-(instancetype)initWithImgPath:(NSString *)imgpath andUserNike:(NSString *)userNike andUserPhone:(NSString *)userPhone andProvince:(NSNumber *)province andDistrict:(NSNumber *)district andCity:(NSNumber *)city andUserAddress:(NSString *)userAddress andUserSex:(NSNumber *)userSex{
    self = [super  init];
    if (self) {
        self.imgPath = imgpath;
        self.userNike = userNike;
        self.userPhone = userPhone;
        self.province = province;
        self.district = district;
        self.city = city;
        self.userAddress = userAddress;
        self.userSex = userSex;
    }
    return self;
}

@end
