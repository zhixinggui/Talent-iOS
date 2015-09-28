//
//  ZZMyOrderVC.m
//  TalentService
//
//  Created by charles on 15/9/28.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZMyOrderVC.h"
#import "ZZSlideDemo.h"
#import "ZZMyOrderTVC.h"
@interface ZZMyOrderVC ()

@end

@implementation ZZMyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZZSlideDemo *selidemo = [[ZZSlideDemo alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];

    NSMutableArray *array = [NSMutableArray  array];
    for (int i = 0; i< 5; i++) {
        ZZMyOrderTVC *vc = [[ZZMyOrderTVC  alloc]init];
        vc.myOrderVcDelegate = self;
        switch (i) {
            case 0:
                vc.orderType = ZZOrderTypeAll;
                vc.title = @"全部";
                break;
            case 1:
                vc.orderType = ZZOrderTypeNoPay;
                vc.title = @"未付款";
                break;
            case 2:
                vc.orderType = ZZOrderTypeDidPay;
                vc.title = @"未消费";
                break;
            case 3:
                vc.orderType = ZZOrderTypeDidJoin;
                vc.title = @"待评价";
                break;
            case 4:
                vc.orderType = ZZOrderTypeDidPast;
                vc.title = @"退款";
                break;
        }
        
        [array  addObject:vc];
    }
    selidemo.conViews = array;
    [self.view addSubview:selidemo];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
