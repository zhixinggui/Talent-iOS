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
#import "ZZSegmentedControl.h"
@interface ZZMyOrderTVC ()<ZZSegmentedControlDelegate>
@property(nonatomic)NSInteger segmentControlIndex;
@property(nonatomic,strong)ZZSegmentedControl *orderSegmentControl;
@end

@implementation ZZMyOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    UINib* nib = [UINib nibWithNibName:@"ZZOrderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:orderCelldentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 130;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        ZZOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCelldentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //取消订单
    [cell.cancelBT addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //点赞
    [cell.goodBT addTarget:self action:@selector(goodOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //吐槽
    [cell.badBT addTarget:self action:@selector(badOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    
}
/**
 *  取消订单
 *
 *  @param button <#button description#>
 */
-(void)cancelOrderAction:(UIButton*)button{
    ZZLog(@"取消订单");
    ZZCancelOrderVC *cancelOrderVc = [[ZZCancelOrderVC alloc]initWithNib];
    [self.navigationController pushViewController:cancelOrderVc animated:YES];
}

/**
 *  点赞
 *
 *  @param button <#button description#>
 */
-(void)goodOrderAction:(UIButton*)button{
    ZZLog(@"点赞");
}

/**
 *  吐槽
 *
 *  @param button <#button description#>
 */
-(void)badOrderAction:(UIButton*)button{
    ZZLog(@"吐槽");
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    ZZSeeOrderVC *detailViewController = [[ZZSeeOrderVC alloc] init];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.self.orderSegmentControl;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

#pragma mark  event delegate
-(void)segmentControl:(ZZSegmentedControl *)segment andIndex:(NSUInteger)index{
    ZZLog(@"切换%ld",index);
    
}


#pragma mark setter andGetter
-(ZZSegmentedControl *)orderSegmentControl{
    if (!_orderSegmentControl) {
        _orderSegmentControl = [[ZZSegmentedControl alloc]initWithItems:@[@"全部",@"未支付",@"已支付",@"已参加",@"已过期"]];
        _orderSegmentControl.delegate = self;
        _orderSegmentControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    }
    return _orderSegmentControl;
}



@end
