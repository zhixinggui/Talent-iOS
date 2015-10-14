//
//  ZZActivity.m
//  TalentService
//
//  Created by zhizhen on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivity.h"
#import "ZZOtherUser.h"
#import "ZZImageContent.h"
#import "NSObject+ZZDataLogic.h"
@implementation ZZActivity
#pragma mark - 解析
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"activityId":@"id"};
}
+(NSDictionary *)objectClassInArray{
    return @{@"userInfoList":[ZZOtherUser  class],@"serviceImgList":[ZZImageContent class]};
}
#pragma mark - 重写系统方法

-(void)setStartTime:(NSString *)startTime{
  _startTime =  [self  dealNoyearDate:startTime];
   
}

-(void)setEndTime:(NSString *)endTime{
    _endTime =  [self  dealNoyearDate:endTime];
}

- (void)setApplyStartTime:(NSString *)applyStartTime{
    _applyStartTime = [self  dealNoyearDate:applyStartTime];
}

-(void)setApplyEndTime:(NSString *)applyEndTime{
    _applyEndTime = [self dealNoyearDate:applyEndTime];
}
-(void)setServicesImg:(NSString *)servicesImg{
    _servicesImg = [servicesImg  getUrlUseEncodAppend:ZZImageUrlAppend(ScreenWidth, NO)];

//  _servicesImg=  [[servicesImg  stringByAppendingString:ZZImageUrlAppend(ScreenWidth, YES)]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
_servicesBigImg = [[servicesImg  stringByAppendingString:ZZImageUrlOrigin(YES)]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(void)setPrice:(NSString *)price{
    
    _price = [NSString  dealFreePrice:price];
}

-(NSString *)detailRule{
    if (_detailRule == nil) {
        NSMutableString *mdetailRule = [NSMutableString  string];
//        if (self.title.length) {
//            [mdetailRule  appendFormat:@"活动标题:%@\n",self.title];
//        }
        if (self.startTime.length && self.endTime.length) {
            [mdetailRule  appendFormat:@"活动时间:%@~%@\n",self.startTime,self.endTime];
        }
        if (self.applyStartTime.length && self.applyEndTime.length) {
            [mdetailRule  appendFormat:@"预定时间:%@~%@\n",self.applyStartTime,self.applyEndTime];
        }
        if (self.address.length) {
            [mdetailRule  appendFormat:@"活动地点:%@\n",self.address];
        }
        if (self.peoples) {
            [mdetailRule  appendFormat:@"活动参加人数:%ld人",self.peoples];
        }
        _detailRule = mdetailRule;
    }
    return _detailRule;
}

/**日期转换*/
- (NSString *)dealYearDate:(NSString *)originDate{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:originDate];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
   return  [fmt  stringFromDate:createDate  ];
}
/**日期转换*/
- (NSString *)dealNoyearDate:(NSString *)originDate{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:originDate];
    fmt.dateFormat = @"MM-dd HH:mm";
    return  [fmt  stringFromDate:createDate  ];
}
@end
