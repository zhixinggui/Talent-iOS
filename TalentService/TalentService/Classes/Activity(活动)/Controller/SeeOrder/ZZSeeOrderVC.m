//
//  ZZSeeOrderVC.m
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSeeOrderVC.h"
#import "ZZSeeOrderView.h"
#import "ZZCancelOrderVC.h"
#import "ZZActivityHttpTool.h"
#import "ZZOrderTopView.h"
#import "ZZOrder.h"
#import "ZZActivity.h"
#import "ZZHudView.h"
#import "ZZSelectPayTypeVC.h"

#import "ZZLoginUserTool.h"

@interface ZZSeeOrderVC ()<ZZBaseOrderViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)UIScrollView *scroView;
@property (nonatomic) CGFloat  toalheight;

@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)ZZOrder *order;

@property (nonatomic, strong)ZZOrderInfoShowView *orderStatusView;
@end

@implementation ZZSeeOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = ZZViewBackColor;
    [self  getOrderDetail];
    /**
     *10.9王雷做修改
     */
//    //获取通知中心单例对象
//    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
//    [center addObserver:self selector:@selector(setUpChild) name:ZZUserNickChangeNoti object:nil];
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
    topView.jump = YES;
    topView.vcDelegate = self;
    [scroView  addSubview:topView];
    self.scroView =scroView;
    [self.view addSubview:scroView];
    
    self.toalheight  = CGRectGetMaxY(topView.frame);
    
    ZZActivity *activity = self.order.serviceInfo;
    [self  setUpShowView:@"订单号：" content:self.order.orderCode];
    [self  setUpShowView:@"订单时间：" content:self.order.orderDate];
    [self  setUpShowView:@"用户名：" content:self.order.userNike];
    [self  setUpShowView:@"手机号：" content:loginUser.userPhone];
    [self  setUpShowView:@"服务时间：" content:activity.startTime];
    [self  setUpShowView:@"服务地点：" content:activity.address];
    [self setUpShowView:@"金额：" content:[self.order showPrice:self.order.price]];
   self.orderStatusView =  [self setUpShowView:@"订单状态：" content:[self.order orderStatus]];
    NSString *buttonTitle = nil;
    switch (self.order.status) {
        case ZZOrderStatusNotPaid:
            buttonTitle = @"立即支付";
            break;
        case ZZOrderStatusPaid:
            buttonTitle = @"取消订单";
            break;
        case ZZOrderStatusComplete:
            buttonTitle = @"立即评价";
            break;
        case ZZOrderStatusExpired:
            buttonTitle = @"申请退款";
            break;
        case ZZOrderStatusEvaluation:
            buttonTitle = nil;
            break;
        case ZZOrderStatusRefund:
            buttonTitle = nil;
            break;
        case ZZOrderStatusCancel:
            buttonTitle = nil;
            break;
       
    }
    if (buttonTitle.length) {
        UIButton *ensure = [[UIButton  alloc]initWithFrame:CGRectMake(edge,edge+self.toalheight, ScreenWidth - 2*edge, 40)];
        ensure.backgroundColor = ZZNatiBarColor;
        ensure.layer.cornerRadius = 20;
        ensure.layer.masksToBounds = YES;
        [ensure  setTitle:buttonTitle forState:UIControlStateNormal];
        [ensure  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
        ensure.tag = self.order.status;
        self.button = ensure;
        [ensure  addTarget:self action:@selector(ensurePhone:) forControlEvents:UIControlEventTouchUpInside];
        [ self.scroView   addSubview:ensure];
        self.toalheight = CGRectGetMaxY(ensure.frame)+edge;
    }
  
    
    scroView.contentSize = CGSizeMake(0, self.toalheight);
}
- (ZZOrderInfoShowView *)setUpShowView:(NSString *)title content:(NSString *)content{
    ZZOrderInfoShowView *showView = [[ZZOrderInfoShowView alloc]initWithFrame:CGRectMake(0, self.toalheight, ScreenWidth, 50)];
    [showView setTitle:title content:content];
    self.toalheight = CGRectGetMaxY(showView.frame);
    [ self.scroView  addSubview:showView];
    
    return showView;
}

- (void)ensurePhone:(UIButton *)btn{
    switch (btn.tag) {
        case ZZOrderStatusPaid:
            [self  cancellOrder];
            break;
        case ZZOrderStatusNotPaid:
            [self  nowPay];
            break;
         case ZZOrderStatusComplete:
            [self  nowEvaluation];
            break;
        case ZZOrderStatusExpired:
            [self  applyRefund];
            break;
    }
    
}
//立即支付
- (void)nowPay{
    ZZSelectPayTypeVC *selectPay = [[ZZSelectPayTypeVC  alloc]init];
    [self.navigationController  pushViewController:selectPay animated:YES];
}
//立即评价
- (void)nowEvaluation{
    [ZZHudView  showMessage:@"正在开发中，敬请期待" time:5 toView:self.view];
}
//申请退款
- (void)applyRefund{
     [ZZHudView  showMessage:@"正在开发中，敬请期待" time:5 toView:self.view];
}
//取消订单
- (void)cancellOrder{
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要取消这个订单吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定 ", nil];
    [alertView show];
    
    
}

#pragma mark -UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        [self  cancellOrderNet];
    }
}
#pragma mark -取消订单
//取消订单的网络请求
- (void)cancellOrderNet{
    [MBProgressHUD  showMessage:ZZNetLoading ];
    [  ZZActivityHttpTool  activityCancellOrder:self.order.orderCode success:^(id json, ZZNetDataType netDataType) {
        
        [MBProgressHUD hideHUD];
        [ZZHudView  showMessage:@"取消成功" time:3 toView:self.view];
        self.order.status = ZZOrderStatusCancel ;
        [self.orderStatusView  setTitle:@"订单状态：" content:[self.order orderStatus]];
        [self.button  removeFromSuperview];
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        [MBProgressHUD hideHUD];
        [ZZHudView  showMessage:@"取消失败，请重试" time:5 toView:self.view];
    }];
}

//订单详情
- (void)getOrderDetail{
    [MBProgressHUD  showMessage:ZZNetLoading toView:self.view];
    [ZZActivityHttpTool  activitySeeOrder:self.orderCode success:^(ZZOrder *order, ZZNetDataType netDataType) {
        [MBProgressHUD  hideAllHUDsForView:self.view animated:YES];
        
        self.order = order;
        [self  setUpChild];
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        [MBProgressHUD  hideAllHUDsForView:self.view animated:YES];
        
        [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self.view action:@selector(getOrderDetail) isBack:NO];
    }];
}
@end
