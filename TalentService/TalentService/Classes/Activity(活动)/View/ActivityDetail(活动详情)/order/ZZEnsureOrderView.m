//
//  ZZEnsureOrderView.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZEnsureOrderView.h"
#import "ZZEnsureOrderController.h"
#import "ZZOrderResultVC.h"
#import "ZZActivityHttpTool.h"
#import "ZZActivityConmitParam.h"
#import "ZZHudView.h"
@implementation ZZEnsureOrderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
    
    }
    return self;
}
- (void)setUpChild{
    [super  setUpChild];
    UIButton *change = [[UIButton  alloc]initWithFrame:CGRectMake(ScreenWidth - space + edge, (self.phoneShowView.frame.size.height - 20)/2, space - 2*edge, 20)];
    [change  setTitle:@"修改" forState:UIControlStateNormal];
    change.titleLabel.font = ZZContentFont;
    [change  setTitleColor:ZZNatiBarColor forState:UIControlStateNormal];
    [change  addTarget:self action:@selector(changePhone) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneShowView  addSubview:change];
    
    UIButton *ensure = [[UIButton  alloc]initWithFrame:CGRectMake(edge,edge+self.toalheight, ScreenWidth - 2*edge, 40)];
    ensure.backgroundColor = ZZNatiBarColor;
    ensure.layer.cornerRadius = 20;
    ensure.layer.masksToBounds = YES;
    [ensure  setTitle:@"确认订单" forState:UIControlStateNormal];
    [ensure  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    [ensure  addTarget:self action:@selector(ensurePhone) forControlEvents:UIControlEventTouchUpInside];
    [self   addSubview:ensure];
    self.toalheight = CGRectGetMaxY(ensure.frame)+edge;
    
    self.contentSize = CGSizeMake(0, self.toalheight);
}

- (void)changePhone{

    
  
}

- (void)ensurePhone{
    ZZActivityConmitParam *commitparam = [[ZZActivityConmitParam  alloc]init];
    commitparam.orderCode = self.order.orderCode;
    commitparam.phone = self.order.phone;
    commitparam.serviceId = @(self.order.serviceBasicInfo.activityId);
    commitparam.servicePrice = self.order.servicePrice;
    
    [MBProgressHUD  showMessage:ZZNetLoading];
    [ZZActivityHttpTool  activityCommitOrder:commitparam success:^(id json, ZZNetDataType netSuccType) {
        [MBProgressHUD  hideHUD];
        ZZOrderResultVC *resultVC = [[ZZOrderResultVC  alloc]init];
        resultVC.orderCode = self.order.orderCode;
        resultVC.result = YES;
        [self.delegateVC.navigationController  pushViewController:resultVC animated:YES];
        
    } failure:^(NSString *error, ZZNetDataType netFialType) {
        [MBProgressHUD  hideHUD];
        [ZZHudView  showMessage:error time:10 toView:self];
        
    }];
    
}
@end
