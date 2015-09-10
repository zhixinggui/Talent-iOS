//
//  ZZFuncitonModel.h
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZFunctionShowRule.h"

typedef enum {
    ZZFuncitonModelTypeReport,//举报
    ZZFuncitonModelTypeStar,//收藏
    ZZFuncitonModelTypeBackHome//返回主页
}ZZFuncitonModelType;
@interface ZZFuncitonModel : NSObject<ZZFunctionShowRuleDelegate>
@property (nonatomic, copy) NSString*  imageName;
@property (nonatomic, copy) NSString *seletedImageName;
@property (nonatomic, copy) NSString*  name;
@property (nonatomic, copy) NSString *seletedName;
@property (nonatomic, assign) ZZFuncitonModelType modelType;
@property (nonatomic) BOOL seleted;
- (instancetype)initWithImageName:(NSString *)imageName
                             name:(NSString *)name
                        modelType:(ZZFuncitonModelType )modelType;
@end
