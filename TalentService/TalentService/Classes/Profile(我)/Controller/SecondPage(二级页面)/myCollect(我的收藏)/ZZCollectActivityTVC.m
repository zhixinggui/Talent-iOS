//
//  ZZCollectActivityTVC.m
//  TalentService
//
//  Created by charles on 15/9/14.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZCollectActivityTVC.h"
#import "ZZActivityCell.h"
#import "ZZMyInfoHttpTool.h"
#import "MJRefresh.h"
@interface ZZCollectActivityTVC ()
@property (nonatomic, strong)NSMutableArray *activityArray;
@property (nonatomic, strong)ZZHomeServiceResult *result;
@end

@implementation ZZCollectActivityTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = [ZZActivityCell  cellHeight];
    [self.tableView  registerNib:[UINib nibWithNibName:@"ZZActivityCell" bundle:nil] forCellReuseIdentifier:[ZZActivityCell   cellXibIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //底部刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreService)];
    
    //头部刷新
    [self getNetData];
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
//    self.tableView.header.automaticallyChangeAlpha = YES;
    //开始进入刷新
    //[self.tableView.header beginRefreshing];
    
}
/**
 *  头部刷新方法
 */
- (void)getNetData{
    [self getMyCollectionListWithPageNo:0 andNumberOfPerPage:10];
}
/**
 *  头部刷新网络请求
 */
-(void)getMyCollectionListWithPageNo:(NSInteger)pageNo andNumberOfPerPage:(NSInteger)numberOfPerPage{
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    [ZZMyInfoHttpTool getMyCollectActivityWithPageNo:pageNo andNumberOfPerPage:numberOfPerPage success:^(ZZHomeServiceResult *result, ZZNetDataType dataType) {
        //请求成功刷新停止
        //[self.tableView.header endRefreshing];
        [MBProgressHUD  hideHUDForView:self.view];
        [MBProgressHUD  showSuccess:@"请求成功"];
        ZZLog(@"啥数据啊:%@",result);
        self.result = result;
        [self.activityArray  removeAllObjects];
        [self.activityArray addObjectsFromArray:result.rows];
        [self.tableView reloadData];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        //[self.tableView.header endRefreshing];
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showError:error];
    }];
}

/**
 *  底部刷新方法
 */
- (void)loadMoreService{
    [self getMoreCollectionListWithPageNo:self.result.page andNumberOfPerPage:2];
}
/**
 *  底部刷新更多请求
 */
- (void)getMoreCollectionListWithPageNo:(NSInteger)pageNo andNumberOfPerPage:(NSInteger)numberOfPerPage{
    [ZZMyInfoHttpTool getMyCollectActivityWithPageNo:pageNo andNumberOfPerPage:numberOfPerPage success:^(ZZHomeServiceResult *result, ZZNetDataType dataType) {
        //请求成功刷新停止
        [self.tableView.footer endRefreshing];
        ZZLog(@"啥数据啊:%@",result);
        self.result = result;
        [self.activityArray addObjectsFromArray:result.rows];
        [self.tableView reloadData];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [self.tableView.footer  endRefreshing];
        [MBProgressHUD  showError:error];
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
    ZZActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZZActivityCell   cellXibIdentifier] forIndexPath:indexPath];
    cell.activity = self.activityArray[indexPath.row];
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
