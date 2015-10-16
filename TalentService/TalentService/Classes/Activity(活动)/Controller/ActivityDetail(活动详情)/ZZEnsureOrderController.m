//
//  ZZEnsureOrderController.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZEnsureOrderController.h"
#import "ZZEnsureOrderView.h"
#import "ZZSelectPayTypeVC.h"
#import "ZZOrderTopView.h"
#import "ZZOrderTopView.h"
#import "ZZActivityConmitParam.h"
#import "ZZActivityHttpTool.h"
#import "ZZOrderResultVC.h"
#import "ZZHudView.h"

#import "ZZLoginUserTool.h"
#import "ZZChangePhoneNumVC.h"

@interface ZZEnsureOrderController ()
@property (nonatomic) CGFloat  toalheight;
@property (nonatomic, strong) ZZOrderInfoShowView *phoneShowView;
@property (nonatomic, strong)UIScrollView *scroView;

@property (nonatomic, strong)UIButton *change;
@property (nonatomic, strong)UIButton *ensure;
@end

@implementation ZZEnsureOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = ZZViewBackColor;
    [self  setUpChild];
    
    /**
     *10.9王雷做修改
     */
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(setUpChild) name:ZZUserNickChangeNoti object:nil];
}


- (void)setUpChild{
    /**
     *10.9王雷做修改
     */
    ZZLoginUser *loginUser = [ZZLoginUserTool  sharedZZLoginUserTool].loginUser;
    UIScrollView *scroView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    ZZOrderTopView *topView = [ZZOrderTopView  orderTopView];
    topView.activity = self.order.serviceInfo;
    topView.y = 64;
    [scroView  addSubview:topView];
    self.scroView =scroView;
    [self.view addSubview:scroView];
    
    self.toalheight  = CGRectGetMaxY(topView.frame);

    ZZActivity *activity = self.order.serviceInfo;

    [self  setUpShowView:@"订单时间：" content:self.order.orderDate];
    [self  setUpShowView:@"用户名：" content:self.order.userNike];
    self.phoneShowView =   [self  setUpShowView:@"手机号：" content:loginUser.userPhone];
    [self  setUpShowView:@"服务时间：" content:activity.startTime];
    [self  setUpShowView:@"服务地点：" content:activity.address];
    [self setUpShowView:@"金额：" content:[self.order showPrice:self.order.price]];
    
    UIButton *change = [[UIButton  alloc]initWithFrame:CGRectMake(ScreenWidth - space + edge, (self.phoneShowView.frame.size.height - 20)/2, space - 2*edge, 20)];
    [change  setTitle:@"修改" forState:UIControlStateNormal];
    change.titleLabel.font = ZZContentFont;
    [change  setTitleColor:ZZNatiBarColor forState:UIControlStateNormal];
    [change  addTarget:self action:@selector(changePhone) forControlEvents:UIControlEventTouchUpInside];
    self.change = change;
    [self.phoneShowView  addSubview:change];
    
    UIButton *ensure = [[UIButton  alloc]initWithFrame:CGRectMake(edge,edge+self.toalheight, ScreenWidth - 2*edge, 40)];
    ensure.backgroundColor = ZZNatiBarColor;
    ensure.layer.cornerRadius = 20;
    ensure.layer.masksToBounds = YES;
    [ensure  setTitle:@"确认订单" forState:UIControlStateNormal];
    [ensure  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    [ensure  addTarget:self action:@selector(ensurePhone) forControlEvents:UIControlEventTouchUpInside];
    [ self.scroView   addSubview:ensure];
    self.ensure=ensure;
    self.toalheight = CGRectGetMaxY(ensure.frame)+edge;
    
    scroView.contentSize = CGSizeMake(0, self.toalheight);
}
- (ZZOrderInfoShowView *)setUpShowView:(NSString *)title content:(NSString *)content{
    ZZOrderInfoShowView *showView = [[ZZOrderInfoShowView alloc]initWithFrame:CGRectMake(0, self.toalheight, ScreenWidth, 50)];
    [showView setTitle:title content:content];
    self.toalheight = CGRectGetMaxY(showView.frame);
    [ self.scroView  addSubview:showView];
    
    return showView;
}
- (void)changePhone{
    ZZChangePhoneNumVC *changePhoneNumVc = [[ZZChangePhoneNumVC alloc]init];
    [self.navigationController pushViewController:changePhoneNumVc animated:YES];
    
    
}

- (void)ensurePhone{
    ZZActivityConmitParam *commitparam = [[ZZActivityConmitParam  alloc]init];
  //  commitparam.orderCode = self.order.orderCode;
    commitparam.phone = self.order.phone;
    commitparam.serviceId = @(self.order.serviceInfo.activityId);
  //  commitparam.servicePrice = self.order.servicePrice;
    
    [MBProgressHUD  showMessage:ZZNetLoading];
    [ZZActivityHttpTool  activityCommitOrder:commitparam success:^(ZZOrder * order, ZZNetDataType netSuccType) {
        [MBProgressHUD  hideHUD];
        ZZOrderResultVC *resultVC = [[ZZOrderResultVC  alloc]init];
        resultVC.orderCode = order.orderCode;
        resultVC.result = YES;
        [self.navigationController  pushViewController:resultVC animated:YES];
        self.order.serviceInfo.isReserve = YES;
        [self.change  removeFromSuperview];
        [self.ensure  removeFromSuperview];
    } failure:^(NSString *error, ZZNetDataType netFialType) {
        [MBProgressHUD  hideHUD];
        [ZZHudView  showMessage:error time:10 toView:self.view];
        
    }];
    
}
@end
