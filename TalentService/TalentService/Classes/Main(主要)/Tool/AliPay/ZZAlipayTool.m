//
//  ZZAlipayTool.m
//  TalentService
//
//  Created by charles on 15/10/21.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZAlipayTool.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"
NSString * const partner = @"2088021604444292";

NSString * const seller = @"ios_android_smart@smart-kids.com";

NSString *const privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANBP6Nl0z1xXrGNk0FuC4mjvEva3HwETYL8gQkgLyNwknMvGaiO9G0m44RHu5KgDSAqYJZasBcuH2BK7GBT71Rd5/uIscYliC6lyFK5WQLSSaA397DFu7zTZ/ZJAGlb/GOobwUAuPq86daLe2/j5sP3McP/Fvng99w2fv9+qQFrPAgMBAAECgYEAjIEZoXL0WmiYUgIxt0e0xupadCZXtzYGz2NG0amBNVtMlvWhqbFnsnYM+TeU6u4rrVmqINKupfVefGPNfnnN4+v8AvN5e+of07oC/kYW63mWjJAGerqjch7/kTSCqexodGbJctwTwiVI+QvIdTCXqJxdhx2dfj5BAk/Rwl4BKGECQQDyAn//T2OaZXz69LTBp5PfdLGtwtF2EX9mHb3ZeCkeziMcvB6T2ctGQrehFK0reH1ERmaUl6QaeZNYxYA7q+3lAkEA3Fq4B6wrjOFTxCgybAFun83puPeTn9RAwTas4WMnyf5H3ogTRzE4Cbl+9lPzSOY8K79efvvPvRqO9YdAajo6owJBAM5+QZant5XyyHwcteqSwQKmQEDB/RVgArMv52CaPYPSYXVQMkr3R5GwtZwU11lDGqdZ5ocdCGGqoIXbJvpDTd0CQQC6Uxt5oWPR5FZob3TzTuKzzfHrrazuYRPATPMyQh3K93DeAkIK2NuBnZB1ydbVtZj7hP3qchLe3C41/v/A0yvxAkBrM3KH7XgitJ/WaWsQLaEESZO2RdCgRrmGLwDM+ZiuMw2riuwHR1anfXXZLKrLSQesX7OGMBAOzc+Qxy7iAM5w";

@implementation ZZAlipayTool

+ (void)aliPayForOrderWithOrderDetail:(ZZOrder *)orderDetail  andPaymentData:(NSString *)paymentData {
    ZZLog(@"密钥: %@",paymentData);
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = orderDetail.orderCode; //订单ID（由商家自行制定）
//    order.productName = orderDetail.title; //商品标题
//    order.productDescription = @""; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",orderDetail.price]; //商品价格
//    order.notifyURL =  @"http://www.xxx.com"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"mengbaopai";
    
    //将商品信息拼接成字符串
    //NSString *orderSpec = [order description];
    //NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    //id<DataSigner> signer = CreateRSADataSigner(privateKey);
    //NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    //NSString *orderString = nil;
    //if (signedString != nil) {
        //orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:paymentData fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            //发出通知 告知订单状态改变
            NSNotification   *noti =  [NSNotification  notificationWithName:ZZOrderStausChangePaySucc object:nil];
            [[NSNotificationCenter  defaultCenter]postNotification:noti];
        }];
    //}
}

@end
