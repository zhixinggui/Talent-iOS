//
//  ZZMyAllActivityTVC.m
//  TalentService
//
//  Created by charles on 15/9/20.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMyAllActivityTVC.h"
#import "ZZMyAllActivityCell.h"
#import "ZZMyJoinOrderVC.h"
#import "ZZMyInfoHttpTool.h"
#import "ZZMyServiceParam.h"
#import "ZZHomeServiceResult.h"
#import <MJRefresh.h>
#import "ZZHudView.h"
#import "ZZActivity.h"


#define numberOfpage 10
@interface ZZMyAllActivityTVC ()
@property (nonatomic, strong)NSMutableArray *activityArray;
@property (nonatomic, strong)ZZHomeServiceResult *result;
@property (nonatomic, strong)ZZActivity *activity;
@end

@implementation ZZMyAllActivityTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的服务";
    //底部刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreService)];
    self.tableView.rowHeight = 50;
    [self getMyServiceList];
}

- (void)getMyServiceList {
     [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    ZZMyServiceParam *myServiceparam = [[ZZMyServiceParam alloc]init];
    myServiceparam.myCenter = @(1);
    self.isEredar = 1;
    myServiceparam.isEredar = @(self.isEredar);
    if ([myServiceparam.myCenter isEqualToNumber:@(1)]) {
        
    }else{
        //myServiceparam.userId =
    }
    myServiceparam.numberOfPerPage = @(numberOfpage);
    myServiceparam.pageNo = @(0);
    [ZZMyInfoHttpTool getmyServiceListWithMyServiceParam:myServiceparam success:^(ZZHomeServiceResult *result, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUDForView:self.view];
        ZZLog(@"啥数据啊:%@",result);
        self.result = result;
        if (self.result.rows.count == 0) {
            
            [MBProgressHUD showMessageClearBackView:@"你还没有服务" toView:self.view ];
        }
        [self.activityArray  removeAllObjects];
        [self.activityArray addObjectsFromArray:result.rows];
        [self.tableView reloadData];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUDForView:self.view];
        [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self action:@selector(getMyServiceList) isBack:NO];
    }];
}

- (void)loadMoreService{
    ZZMyServiceParam *myServiceparam = [[ZZMyServiceParam alloc]init];
    myServiceparam.myCenter = @(1);
    myServiceparam.isEredar = @(1);
    if ([myServiceparam.myCenter isEqualToNumber:@(1)]) {
        
    }else{
        //myServiceparam.userId =
    }
    myServiceparam.numberOfPerPage = @(numberOfpage);
    myServiceparam.pageNo = @(self.result.page);
    [ZZMyInfoHttpTool getmyServiceListWithMyServiceParam:myServiceparam success:^(ZZHomeServiceResult *result, ZZNetDataType dataType) {
        //请求成功刷新停止
        [self.tableView.footer endRefreshing];
        ZZLog(@"啥数据啊:%@",result);
        self.result = result;
        [self.activityArray addObjectsFromArray:result.rows];
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

    return self.activityArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.activity = self.activityArray[indexPath.row];
    cell.textLabel.text = self.activity.title;
    cell.detailTextLabel.text = @"未开始";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor redColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    self.activity = self.activityArray[indexPath.row];
    ZZMyJoinOrderVC *jionOrderTvc = [[ZZMyJoinOrderVC alloc]init];
    jionOrderTvc.serviceId = self.activity.activityId;
    [self.navigationController pushViewController:jionOrderTvc animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -Setters and Getters
-(NSMutableArray *)activityArray{
    if (_activityArray == nil) {
        _activityArray = [NSMutableArray  array];
    }
    return _activityArray;
}

-(void)setResult:(ZZHomeServiceResult *)result{
    _result = result;
    if (result.page == result.total) {
        [self.tableView.footer noticeNoMoreData];
    }else{
        [self.tableView.footer resetNoMoreData];
    }
}
@end
