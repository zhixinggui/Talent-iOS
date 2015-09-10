//
//  ZZFuncitonModel.m
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZFuncitonModel.h"

@implementation ZZFuncitonModel
- (instancetype)initWithImageName:(NSString *)imageName
                             name:(NSString *)name
                        modelType:(ZZFuncitonModelType )modelType
                {
    self = [super  init];
    if (self) {
        self.imageName = imageName;
        self.name = name;
        self.modelType = modelType;
       
    }
    return self;
}

-(NSString *)showImageName{
    if (self.seleted && self.seletedImageName) {
        return self.seletedImageName;
    }else{
          return self.imageName;
    }
  
}

-(NSString *)name{
    if (self.seleted && self.seletedName) {
        return self.seletedName;
    }else{
        return self.name;
    }
}
@end
