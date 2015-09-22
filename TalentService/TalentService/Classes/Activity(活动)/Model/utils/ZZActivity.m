//
//  ZZActivity.m
//  TalentService
//
//  Created by zhizhen on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivity.h"
#import "ZZOtherUser.h"
#define ZZImageScrwidth  [NSString  stringWithFormat:@"@%.0fw_1pr_2o_1l|watermark=2&text=6JCM5a6d5rS-&type=ZmFuZ3poZW5nc2h1c29uZw&size=20&t=79&p=5",ScreenWidth * [UIScreen  mainScreen].scale]
@implementation ZZActivity
#pragma mark - 解析
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"activityId":@"id"};
}
+(NSDictionary *)objectClassInArray{
    return @{@"userInfoList":[ZZOtherUser  class]};
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

    NSString *urlString = [NSString  stringWithFormat:@"%@%@",servicesImg,ZZImageScrwidth];
    //转字符串
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    _servicesImg = urlString;
   
//    self.imgUrl = [NSString  stringWithFormat:@"%@%@",servicesImg,ZZImageScrwidth];
}

-(void)setPrice:(NSString *)price{
    
    _price = [self  dealNumber:price];
}

-(NSString *)detailRule{
    if (_detailRule == nil) {
        NSMutableString *mdetailRule = [NSMutableString  string];
        if (self.title.length) {
            [mdetailRule  appendFormat:@"活动标题:%@\n",self.title];
        }
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
/**价格转换*/
- (NSString *)dealNumber:(NSString *)sourceNumber
{
    
    NSString *str = sourceNumber ;
    if ([sourceNumber  safeString] && [sourceNumber doubleValue]) {
        // 小数点的位置
        NSUInteger dotIndex = [str rangeOfString:@"."].location;
        if (dotIndex != NSNotFound && str.length - dotIndex > 2) { // 小数超过2位
            str = [str substringToIndex:dotIndex + 3];
        }
        return str;
    }else{
        return @"免费";
    }
    
  
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
