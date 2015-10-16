//
//  ZZJoinOrderTVC.m
//  TalentService
//
//  Created by charles on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZJoinOrderTVC.h"
#import "ZZJoinOrderCell.h"
#import "ZZSegmentedControl.h"
#import "ZZTestingVC.h"
#import "ZZMyInfoHttpTool.h"
#import "MJRefresh.h"
#import "ZZHudView.h"

#define numberOfpage 10
@interface ZZJoinOrderTVC ()
@property (nonatomic,  copy)NSString *orderParam;
@property (nonatomic, strong) ZZOrderResult *orderResult;
@property (nonatomic, strong) NSMutableArray *orderArray;
@end

@implementation ZZJoinOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib* nib = [UINib nibWithNibName:@"ZZJoinOrderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:jionOrderCelldentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 76;
    
    //底部刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOrder)];
    
    //第一次请求数据
    [self getNetData];
    
}

- (void)getNetData{
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    ZZOrderParam *orderParam = [[ZZOrderParam alloc]init];
    orderParam.queryType = @(1);
    orderParam.serviceId = @(self.serviceId);
    orderParam.status = self.orderParam;
    orderParam.pageNo = @(0);
    orderParam.numberOfPerPage = @(numberOfpage);
    [ZZMyInfoHttpTool getMyOrderListWithOrderParam:orderParam success:^(ZZOrderResult *orderResult, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUDForView:self.view];
        self.orderResult = orderResult;
        if (self.orderResult.rows.count == 0) {
            
            [MBProgressHUD showMessageClearBackView:@"没有订单" toView:self.view ];
        }
        [self.orderArray removeAllObjects];
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
    orderParam.queryType = @(1);
    orderParam.status = self.orderParam;
    orderParam.serviceId = @(self.serviceId);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.orderArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZJoinOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:jionOrderCelldentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZZLog(@"有没有值:%@",self.orderArray);
    cell.order = self.orderArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}


#pragma mark - Table view delegate
/*
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    ZZNextJionOrderTVC *detailViewController = [[ZZNextJionOrderTVC alloc] initWithNib];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSString *)orderParam{
    if (_orderParam) {
        return _orderParam;
    }
    switch (self.orderType) {
        case ZZOrderTypeDidTest:
            return @"3,5";
            
        case ZZOrderTypeNoTest:
            return @"2,4";
            
            default:
            return @"";
    }
}

#pragma mark -Setters and Getters
-(NSMutableArray *)orderArray{
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
- (void)setOrderResult:(ZZOrderResult *)orderResult {
    _orderResult = orderResult;
    if (orderResult.page == orderResult.total) {
        [self.tableView.footer endRefreshingWithNoMoreData];
    }else {
        [self.tableView.footer resetNoMoreData];
    }
}
@end
