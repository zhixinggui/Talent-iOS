//
//  ZZHomeViewController.m
//  TalentService
//
//  Created by zhizhen on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

static   NSUInteger const HomeNumCount = 10;
#import "ZZHomeViewController.h"
#import "ZZActivityCell.h"
#import "ZZHeadView.h"
#import "ZZTableHeadView.h"
#import "ZZActivityDetailController.h"
#import "ZZApplyVC.h"
#import "ZZHomeHttpTool.h"
#import "MJRefresh.h"
#import "ZZHudView.h"
@interface ZZHomeViewController ()
@property (nonatomic, strong)ZZHeadView *headView;
@property (nonatomic, strong)NSMutableArray *activityArray;
@property (nonatomic, strong)ZZTableHeadView *tableHeadView;
@property (nonatomic, strong)ZZHomeServiceParam *lastParam;
@property (nonatomic, strong)ZZHomeServiceResult *result;
@end

@implementation ZZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZZViewBackColor;
   //设置tableview的相关属性
    [self setUpTableView];
    
    [self  setUpRightBarItem];
    
    [self  getNetData];

}
//设置tableview的相关属性
- (void)setUpTableView{
    self.tableView.rowHeight = [ZZActivityCell  cellHeight];
    //一定要在tableview 分割线设置之前
     [self.tableView  registerNib:[UINib nibWithNibName:@"ZZActivityCell" bundle:nil] forCellReuseIdentifier:[ZZActivityCell  cellXibIdentifier]];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //底部刷新
    self.tableView.footer =   [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreService)];
 
    //头部刷新
    self.tableView.header =  [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    self.tableView.header.automaticallyChangeAlpha = YES;
    [self.tableView.header  beginRefreshing];
    
}
- (void)setUpRightBarItem{
    UIBarButtonItem *barItem = [[UIBarButtonItem  alloc]initWithTitle:@"申请达人" style:UIBarButtonItemStyleDone target:self action:@selector(applySuper)];
    self.navigationItem.rightBarButtonItem = barItem;
}
#pragma mark - event response
- (void)applySuper{
    [ZZHudView  showMessage:@"dddd" animated:YES];
   pushVC(ZZApplyVC);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZActivityCell *cell = [tableView  dequeueReusableCellWithIdentifier:[ZZActivityCell  cellXibIdentifier] ];
    cell.activity = self.activityArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.headView.height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  return   self.headView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZActivityDetailController *actDetailVC = [[ZZActivityDetailController  alloc]init];
    ZZActivity *activity = self.activityArray[indexPath.row];;
    actDetailVC.activityId =activity.activityId;
    [self.navigationController  pushViewController:actDetailVC animated:YES];
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark
- (void)getNetData{

    //请求推荐达人
  //[MBProgressHUD showMessage:ZZNetLoading ];
    [ZZHomeHttpTool  homeRcommoned:1 success:^(NSArray *recoms, ZZNetDataType netDataType) {
     
        self.tableHeadView.talents = recoms;
        self.tableView.tableHeaderView = self.tableHeadView;
        [self.tableView reloadData];
       
    } failure:^(NSString *error, ZZNetDataType netDataType) {
 
    }];
    
    //请求热门推荐
    ZZHomeServiceParam *homeParam = [[ZZHomeServiceParam  alloc]init];
    homeParam.pageNo = @(0);
    homeParam.isRecommoned = @(1);
    homeParam.numberOfPerPage = @(HomeNumCount);
    
    self.lastParam = homeParam;
    [ZZHomeHttpTool  homeServices:homeParam success:^(ZZHomeServiceResult *result, ZZNetDataType netDataType) {
        [self.tableView.header endRefreshing];
        if (self.lastParam != homeParam) {
            return ;
        }
        self.result = result;
        ZZLog(@",,%@",[NSThread currentThread]);
        [self.activityArray  removeAllObjects];
        [self.activityArray addObjectsFromArray:result.rows];
        [self.tableView  reloadData];
        
    } failure:^(NSString *error, ZZNetDataType netDataType) {
          [self.tableView.header endRefreshing];
        if (self.lastParam != homeParam) {
            return ;
        }
         [MBProgressHUD  showError:error];
        self.lastParam = nil;
      
    }];
}

- (void)loadMoreService{
    ZZHomeServiceParam *homeParam = [[ZZHomeServiceParam  alloc]init];
    homeParam.pageNo = @(self.result.page);
    homeParam.isRecommoned = @(1);
    homeParam.numberOfPerPage = @(HomeNumCount);
    self.lastParam = homeParam;
    [ZZHomeHttpTool  homeServices:homeParam success:^(ZZHomeServiceResult *result, ZZNetDataType netDataType) {
        [self.tableView.footer  endRefreshing];
        if (self.lastParam != homeParam) {
            return ;
        }
        self.result = result;
        [self.activityArray addObjectsFromArray:result.rows];
        [self.tableView  reloadData];
    
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        
        [self.tableView.footer  endRefreshing];
        if (self.lastParam != homeParam) {
            return ;
        }
        [MBProgressHUD  showError:error];
    }];
}
#pragma mark -lazy load

-(void)setResult:(ZZHomeServiceResult *)result{
    _result = result;
    if (result.page == result.total) {
        [self.tableView.footer noticeNoMoreData];
    }else{
        [self.tableView.footer resetNoMoreData];
    }
}
-(NSMutableArray *)activityArray{
    if (_activityArray == nil) {
        _activityArray = [NSMutableArray  array];
    }
    return _activityArray;
}

-(ZZHeadView *)headView{
    if (_headView == nil) {
        _headView = [[[NSBundle  mainBundle]loadNibNamed:@"ZZHeadView" owner:self options:nil] lastObject];
    }
    return _headView;
}

-(ZZTableHeadView *)tableHeadView{
    if (_tableHeadView == nil) {
        _tableHeadView = [[ZZTableHeadView  alloc]init];
    }
    return _tableHeadView;
}
@end
