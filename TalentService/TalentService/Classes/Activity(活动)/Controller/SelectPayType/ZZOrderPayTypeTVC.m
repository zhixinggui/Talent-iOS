//
//  ZZOrderPayTypeTVC.m
//  TalentService
//
//  Created by charles on 15/10/23.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZOrderPayTypeTVC.h"
#import "ZZOrderPayCell.h"
#import "ZZLayerButton.h"
#import "ZZMyInfoHttpTool.h"
#import "ZZAlipayTool.h"
@interface ZZOrderPayTypeTVC ()
@property (strong, nonatomic) IBOutlet UIView *orderHeadView;
@property (weak, nonatomic) IBOutlet UILabel *orderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (strong, nonatomic) IBOutlet UIView *footHeadView;
@property (weak, nonatomic) IBOutlet UILabel *orderTotallyLabel;
@property (strong, nonatomic) IBOutlet ZZLayerButton *enterButton;
@property (nonatomic ,strong)NSArray *payType;
@end

@implementation ZZOrderPayTypeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    UINib* nib = [UINib nibWithNibName:@"ZZOrderPayCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:orderPayCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    self.tableView.tableHeaderView = self.orderHeadView;
    self.tableView.tableFooterView = self.footHeadView;
    if (!self.order.serviceInfo.title) {
        self.orderNameLabel.text = [NSString stringWithFormat:@"订单名称：%@",self.order.title];
    }else {
        self.orderNameLabel.text = [NSString stringWithFormat:@"订单名称：%@",self.order.serviceInfo.title];
    }
    self.orderPriceLabel.text = [NSString stringWithFormat:@"订单金额：￥%@",self.order.price];
    self.orderTotallyLabel.text = [NSString stringWithFormat:@"还需支付：￥%@",self.order.price];
    [self aliPayOrder];
}

- (void)aliPayOrder {
    ZZLog(@"orderCode: %@",self.order.orderCode);
    [MBProgressHUD  showMessage:ZZNetLoading toView:self.view];
    [ZZMyInfoHttpTool orderAlipayWithOrderId:self.order.orderCode success:^(NSArray * orderPay, ZZNetDataType dataType) {
        self.payType = orderPay;
        [self.tableView reloadData];
        [MBProgressHUD  hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self.view action:@selector(aliPayOrder) isBack:NO];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.payType.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZOrderPayCell *cell = [tableView dequeueReusableCellWithIdentifier:orderPayCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
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
- (IBAction)didClickOnPay:(ZZLayerButton *)sender {
    ZZLog(@"确认支付");
#warning 现在支付方式是写死的就是支付宝 到时候要修改
    ZZAlipayOrderResult *payResult = self.payType[0];
    [ZZAlipayTool aliPayForOrderWithOrderDetail:self.order andPaymentData:payResult.paymentData];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
