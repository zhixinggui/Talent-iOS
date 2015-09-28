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

#define numberOfpage 10

@interface ZZMyOrderTVC ()<ZZOrderCellDelegate>
@property(nonatomic)NSInteger segmentControlIndex;
@property(nonatomic)NSInteger selcetedNumber;
@property (nonatomic, strong) ZZOrderResult *orderResult;
@property (nonatomic, strong) NSMutableArray *orderArray;

@property (nonatomic,  copy)NSString *orderParam;
@end

@implementation ZZMyOrderTVC


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

- (void)getNetData{
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    [ZZMyInfoHttpTool getMyOrderListWithQueryType:0 andStatus:self.orderParam andPageNo:0 andNumberOfPerPage:numberOfpage success:^(ZZOrderResult *orderResult, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUDForView:self.view];
        self.orderResult = orderResult;
        if (self.orderResult.rows.count == 0) {
            [MBProgressHUD showMessageClearBackView:@"你还没有下单" toView:self.view];
        }
        [self.orderArray removeAllObjects];
        [self.orderArray addObjectsFromArray:self.orderResult.rows];
        [self.tableView reloadData];
        ZZLog(@"数组列表:%@",self.orderArray);
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUDForView:self.view];
        [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self action:@selector(getNetData) isBack:NO];
    }];
}

/**
 *  底部更多刷新方法
 */
- (void)loadMoreOrder {
    [ZZMyInfoHttpTool getMyOrderListWithQueryType:0 andStatus:self.orderParam andPageNo:self.orderResult.page andNumberOfPerPage:numberOfpage success:^(ZZOrderResult *orderResult, ZZNetDataType dataType) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    [self.myOrderVcDelegate.navigationController pushViewController:seeOrderVc animated:YES];
}

#pragma mark - ZZOrderCellDelegate
- (void)didClickOnCell:(ZZOrderCell *)orderCell andOrderStatus:(ZZOrderStatus)orderStatus {
    ZZLog(@"订单类型:%u",orderStatus);
    
}



#pragma mark setter andGetter

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
