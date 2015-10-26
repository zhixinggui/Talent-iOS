//
//  ZZOrder.m
//  TalentService
//
//  Created by zhizhen on 15/9/22.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZOrder.h"
#import "NSObject+ZZDataLogic.h"
NSString * const ZZOrderStausChangePaySucc = @"ZZOrderStausChangePaySucc"; //订单状态改变  支付成功
NSString * const ZZOrderStausChangeCancellOrderSucc = @"ZZOrderStausChangeCancellOrderSucc"; //订单状态改变  取消订单成功
NSString * const ZZOrderStausChangeEvaluationSucc = @"ZZOrderStausChangeEvaluationSucc"; //订单状态改变  评价成功
NSString * const ZZOrderStausChangeRefundSucc = @"ZZOrderStausChangeRefundSucc"; //订单状态改变  退款成功
@implementation ZZOrder
#pragma mark - get&set
-(void)setStatus:(ZZOrderStatus)status{
  
    ZZOrderStatus orderStatus;
    switch (status) {
        case 1:
      
            orderStatus = ZZOrderStatusNotPaid;
            break;
        case 2:
       
          orderStatus= ZZOrderStatusPaid;
            break;
        case 3:
         
            orderStatus = ZZOrderStatusComplete;
            break;
        case 4:
          
           orderStatus = ZZOrderStatusExpired;
            break;
        case 5:
          
            orderStatus = ZZOrderStatusEvaluation;
            break;
        case 6:

           orderStatus = ZZOrderStatusRefund;
            break;
        case 7:
   
            orderStatus = ZZOrderStatusCancel;
            break;
    }
    _status = orderStatus;
}

-(void)setServicesImg:(NSString *)servicesImg{
    _servicesImg = [servicesImg  getUrlUseEncodAppend:ZZImageUrlAppend(ScreenWidth, NO)];
}

-(void)setServicePrice:(NSNumber *)servicePrice{
    _servicePrice = [NSNumber  dealNum:servicePrice];
}

-(void)setPrice:(NSNumber *)price{
    _price = [NSNumber dealNum:price];
}

-(void)setDiscountPrice:(NSNumber *)discountPrice{
    _discountPrice = [NSNumber  dealNum:discountPrice];
}
-(void)setOrderDate:(NSString *)orderDate{
    _orderDate = [self dealHourDate:orderDate];
}

#pragma mark - private methods
- (NSString *)showPrice:(NSNumber *)price{
    NSString *str = [price description];
    // 小数点的位置
    NSUInteger dotIndex = [str rangeOfString:@"."].location;
    if (dotIndex != NSNotFound && str.length - dotIndex > 2) { // 小数超过2位
        str = [str substringToIndex:dotIndex + 3];
    }
    return str ? [str stringByAppendingString:@"元"] :@"免费";
}

/**日期转换*/
- (NSString *)dealHourDate:(NSString *)originDate{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *createDate = [fmt dateFromString:originDate];
    fmt.dateFormat = @"yyyy.MM.dd HH:mm";
    return  [fmt  stringFromDate:createDate  ];
}

#pragma mark -  methods
- (NSString *)orderStatus{
    switch (self.status) {
        case ZZOrderStatusNotPaid:
            return @"未支付";
        case ZZOrderStatusPaid:
            return @"已预定";
        case ZZOrderStatusComplete:
            return @"已参加";
        case ZZOrderStatusExpired:
            return @"已过期";
        case ZZOrderStatusEvaluation:
            return @"已评价";
        case ZZOrderStatusRefund:
            return @"已退款";
        case ZZOrderStatusCancel:
            return @"已取消";
    }
}
@end
