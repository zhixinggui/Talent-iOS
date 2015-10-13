//
//  ZZMyOrderTVC.m
//  TalentService
//
//  Created by charles on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMyOrderTVC.h"
#import "ZZOrderCell.h"
#import "ZZJoinOrderCell.h"
#import "ZZCancelOrderVC.h"
#import "ZZSeeOrderVC.h"
#import "ZZEvaluationTVC.h"
#import "ZZMyInfoHttpTool.h"
#import "MJRefresh.h"
#import "ZZHudView.h"
#import "ZZEmptyView.h"
#import "ZZSelectPayTypeVC.h"
#import "ZZActivityHttpTool.h"

#import "ZZOrderParam.h"

#define numberOfpage 10

@interface ZZMyOrderTVC ()<ZZOrderCellDelegate>
@property(nonatomic)NSInteger segmentControlIndex;
@property(nonatomic)NSInteger selcetedNumber;
@property (nonatomic, strong) ZZOrderResult *orderResult;
@property (nonatomic, strong) NSMutableArray *orderArray;

@property (nonatomic,  copy)NSString *orderParam;

@property (nonatomic, strong)ZZEmptyView *emptyView;

@property (nonatomic)BOOL  showTip;
@end

@implementation ZZMyOrderTVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UINib* nib = [UINib nibWithNibName:@"ZZOrderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:orderCelldentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 130;
    //底部刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOrder)];
    
    //第一次请求数据
    [self getNetData];
    
}

//ZZOrderTypeAll = 1,//全部
//ZZOrderTypeNoPay,//未支付
//ZZOrderTypeDidPay,//已支付
//ZZOrderTypeDidJoin,//已参加
//ZZOrderTypeDidPast,//已过期
-(void)setOrderType:(ZZOrderType)orderType{
    _orderType = orderType;
    switch (orderType) {
        case ZZOrderTypeAll:
            self.orderParam = @"";
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetData) name:ZZOrderStausChangeCancellOrderSucc object:nil];
             [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetData) name:ZZOrderStausChangeEvaluationSucc object:nil];
             [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetData) name:ZZOrderStausChangePaySucc object:nil];
             [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetData) name:ZZOrderStausChangeRefundSucc object:nil];
            break;
        case ZZOrderTypeNoPay:
            self.orderParam = @"1";
             [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetData) name:ZZOrderStausChangePaySucc object:nil];
            break;
        case ZZOrderTypeDidPay:
            self.orderParam = @"2,4";
             [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetData) name:ZZOrderStausChangeRefundSucc object:nil];
            break;
        case ZZOrderTypeDidJoin:
            self.orderParam = @"3";
              [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetData) name:ZZOrderStausChangeEvaluationSucc object:nil];
            break;
        case ZZOrderTypeDidPast:
            self.orderParam = @"6";
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetData) name:ZZOrderStausChangeRefundSucc object:nil];
            break;
            default:
            break;
    }
}
/*
- (void)getNetData{
        self.showTip = NO;
        [self.orderArray removeAllObjects];
        [self.tableView  reloadData];
        [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    
    ZZOrderParam *orderParam = [[ZZOrderParam alloc]init];
    orderParam.queryType = @(0);
    orderParam.status = self.orderParam;
    orderParam.pageNo = @(0);
    orderParam.numberOfPerPage = @(numberOfpage);
    [ZZMyInfoHttpTool getMyOrderListWithOrderParam:(ZZOrderParam *)orderParam success:^(ZZOrderResult *orderResult, ZZNetDataType dataType) {
            [MBProgressHUD  hideHUDForView:self.view];
            self.orderResult = orderResult;
            self.showTip = YES;
            [self.orderArray addObjectsFromArray:self.orderResult.rows];
            [self.tableView reloadData];
            
        } failure:^(NSString *error, ZZNetDataType datatype) {
            [MBProgressHUD  hideHUDForView:self.view];
            [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self action:@selector(getNetData) isBack:NO];
        }];
}
*/

/**
 *  底部更多刷新方法
 */
/*
- (void)loadMoreOrder {
    ZZOrderParam *orderParam = [[ZZOrderParam alloc]init];
    orderParam.queryType = @(0);
    orderParam.status = self.orderParam;
    orderParam.pageNo = @(self.orderResult.page);
    orderParam.numberOfPerPage = @(numberOfpage);
    [ZZMyInfoHttpTool getMyOrderListWithOrderParam:(ZZOrderParam *)orderParam success:^(ZZOrderResult *orderResult, ZZNetDataType dataType) {
        //请求成功刷新停止
        [self.tableView.footer endRefreshing];
        self.orderResult = orderResult;
        [self.orderArray addObjectsFromArray:self.orderResult.rows];
        [self.tableView reloadData];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [self.tableView.footer  endRefreshing];
        [ZZHudView  showMessage:error time:3 toView:self.view];
    }];
}

*/

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    self.emptyView.hidden = self.showTip == YES ?  self.orderArray.count > 0 :YES;
        return self.orderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCelldentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.order = self.orderArray[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZSeeOrderVC *seeOrderVc = [[ZZSeeOrderVC alloc] init];
    ZZOrder *order = self.orderArray[indexPath.row];
    seeOrderVc.orderCode = order.orderCode;
    [self.myOrderVcDelegate.navigationController pushViewController:seeOrderVc animated:YES];
}

#pragma mark - ZZOrderCellDelegate
- (void)didClickOnCell:(ZZOrderCell *)orderCell order:(ZZOrder *)order orderStatus:(NSInteger)orderStatus{

    switch (orderStatus) {
        case ZZOrderStatusNotPaid:
              [self  cancellOrder:order];
           
            break;
         case ZZOrderStatusPaid:
           ZZOrderStatusExpired:
            if ([order.price isEqual:@(0)]) {
                [self  cancellOrder:order];
            }else {
                [self  applyRefund:order];
            }
            
            break;
        case ZZOrderStatusComplete:
            [self nowEvaluation:order];
            break;
       case 0:
           [self nowPay:order];
            break;
    }
    
}


//立即支付
- (void)nowPay:(ZZOrder *)order{
    ZZSelectPayTypeVC *selectPay = [[ZZSelectPayTypeVC  alloc]init];
    [self.myOrderVcDelegate.navigationController  pushViewController:selectPay animated:YES];
}
//立即评价
- (void)nowEvaluation:(ZZOrder *)order{
//    ZZEvaluationTVC *evaluationTvc = [[ZZEvaluationTVC alloc]init];
//    [self.myOrderVcDelegate.navigationController pushViewController:evaluationTvc animated:YES];
    [ZZHudView  showMessage:@"正在开发中，敬请期待" time:5 toView:self.view];
}
//申请退款
- (void)applyRefund:(ZZOrder *)order{
    [ZZHudView  showMessage:@"正在开发中，敬请期待" time:5 toView:self.view];
}
#pragma mark -网络请求
//取消订单
- (void)cancellOrder:(ZZOrder *)order{
    [MBProgressHUD  showMessage:ZZNetLoading ];
    [  ZZActivityHttpTool  activityCancellOrder:order.orderCode success:^(id json, ZZNetDataType netDataType) {
        
        [MBProgressHUD hideHUD];
        [ZZHudView  showMessage:@"取消成功" time:3 toView:self.view];
        order.status = ZZOrderStatusCancel ;

    } failure:^(NSString *error, ZZNetDataType netDataType) {
        [MBProgressHUD hideHUD];
        [ZZHudView  showMessage:@"取消失败，请重试" time:5 toView:self.view];
    }];
}

- (void)getNetData{
    self.showTip = NO;
    [self.orderArray removeAllObjects];
    [self.tableView  reloadData];
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    ZZOrderParam *orderParam = [[ZZOrderParam alloc]init];
    orderParam.queryType = @(0);
    orderParam.status = self.orderParam;
    orderParam.pageNo = @(0);
    orderParam.numberOfPerPage = @(numberOfpage);
    [ZZMyInfoHttpTool getMyOrderListWithOrderParam:(ZZOrderParam *)orderParam success:^(ZZOrderResult *orderResult, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUDForView:self.view];
        self.orderResult = orderResult;
        self.showTip = YES;
        [self.orderArray addObjectsFromArray:self.orderResult.rows];
        [self.tableView reloadData];
        
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUDForView:self.view];
        [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self action:@selector(getNetData) isBack:NO];
    }];
}

/**
 *  底部更多刷新方法
 */
- (void)loadMoreOrder {
    ZZOrderParam *orderParam = [[ZZOrderParam alloc]init];
    orderParam.queryType = @(0);
    orderParam.status = self.orderParam;
    orderParam.pageNo = @(self.orderResult.page);
    orderParam.numberOfPerPage = @(numberOfpage);
    [ZZMyInfoHttpTool getMyOrderListWithOrderParam:(ZZOrderParam *)orderParam success:^(ZZOrderResult *orderResult, ZZNetDataType dataType) {
        //请求成功刷新停止
        [self.tableView.footer endRefreshing];
        self.orderResult = orderResult;
        [self.orderArray addObjectsFromArray:self.orderResult.rows];
        [self.tableView reloadData];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [self.tableView.footer  endRefreshing];
        [ZZHudView  showMessage:error time:3 toView:self.view];
    }];
}

-(void)dealloc{
    [[NSNotificationCenter  defaultCenter] removeObserver:self];
}
#pragma mark setter andGetter
-(ZZEmptyView *)emptyView{
    if (_emptyView == nil) {
        _emptyView = [ZZEmptyView  emptyView];
        _emptyView.tipTitle = @"没有相关订单";
    
      _emptyView.frame = CGRectMake(0, 0 , ScreenWidth, ScreenHeight );
        [self.view  addSubview:_emptyView];
    }
    return _emptyView;
}
-(NSString *)orderParam{
    if (_orderParam) {
        return _orderParam;
    }
    switch (self.orderType) {
        case ZZOrderTypeAll:
            return @"";
    
        case ZZOrderTypeNoPay:
         return @"1";
      
        case ZZOrderTypeDidPay:
         return @"2,4";
       
        case ZZOrderTypeDidJoin:
          return @"3";

        case ZZOrderTypeDidPast:
         return @"6";
            
            default:
            return @"";
    }
}
-(NSMutableArray *)orderArray{
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}

- (void)setOrderResult:(ZZOrderResult *)orderResult {
    _orderResult = orderResult;
    if (orderResult.page == orderResult.total) {
        [self.tableView.footer noticeNoMoreData];
    }else {
        [self.tableView.footer resetNoMoreData];
    }
}

@end
