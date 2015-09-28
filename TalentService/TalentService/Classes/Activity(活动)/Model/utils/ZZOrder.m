//
//  ZZOrder.m
//  TalentService
//
//  Created by zhizhen on 15/9/22.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZOrder.h"

@implementation ZZOrder

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

- (NSString *)showPrice:(NSNumber *)price{
    NSString *str = [price description];
    // 小数点的位置
    NSUInteger dotIndex = [str rangeOfString:@"."].location;
    if (dotIndex != NSNotFound && str.length - dotIndex > 2) { // 小数超过2位
        str = [str substringToIndex:dotIndex + 3];
    }
    return str ? [str stringByAppendingString:@"元"] :@"免费";
}

-(void)setServicesImg:(NSString *)servicesImg{
    _servicesImg = [servicesImg  getUrlUseEncodAppend:ZZImageUrlAppend(60.0, NO)];
}
@end
