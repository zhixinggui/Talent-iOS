//
//  ZZUMLoginModel.m
//  TalentService
//
//  Created by zhizhen on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZUMLoginModel.h"

@implementation ZZUMLoginModel
- (instancetype)initWithImageName:(NSString *)imageName
                        shareType:(NSString *)shareType
                        loginType:(ZZUMLoginType )loginType
                             name:(NSString *)name{
    self = [super  init];
    if (self) {
        self.imageName = imageName;
        self.shareType = shareType;
        self.loginType = loginType;
        self.name = name;
    }
    return self;
}

@end
