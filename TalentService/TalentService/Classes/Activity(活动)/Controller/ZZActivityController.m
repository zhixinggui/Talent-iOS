//
//  ZZActivityController.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

typedef enum {
  ZZSelectorTypeCity = 1,
    ZZSelectorTypeType,
    ZZSelectorTypeStatus
} ZZSelectorType;

static   NSUInteger const ActivityNumCount = 10;
#import "ZZActivityController.h"
#import "ZZActivityCell.h"
#import "ZZMenuButton.h"
#import "ZZTopMenuView.h"
#import "ZZActivityDetailController.h"

#import "ZZActivityCity.h"
#import "ZZActivityStatus.h"
#import "ZZActivityType.h"
#import "ZZPopMenu.h"
#import "ZZSelectorView.h"
#import "ZZActivityHttpTool.h"
#import "MJRefresh.h"
#import "ZZHudView.h"
#import "ZZEmptyView.h"
@interface ZZActivityController ()<ZZSelectorViewDlegate,ZZPopMenuDelegate>
/**活动请求到的数组*/
@property (nonatomic, strong)NSMutableArray *activityArray;
/** 城市选择*/
@property (nonatomic, strong)ZZMenuButton *cityMenuBtn;
/**城市选择*/
@property (nonatomic, strong)ZZMenuButton *typeMenuBtn;
/**状态选择  */
@property (nonatomic, strong)ZZMenuButton *statusMenuBtn;
/**顶部选择菜单  */
@property (nonatomic, strong)ZZTopMenuView  *topMenuView;

/**记录选中了那个选择菜单  */
@property (nonatomic, strong)ZZMenuButton *selectMenuBtn;
/**选中的城市  */
@property (nonatomic, strong)ZZActivityCity *selectedCity;
/**选中的状态 */
@property (nonatomic, strong)ZZActivityStatus *selectedStatus;
/**选中的类型  */
@property (nonatomic, strong)ZZActivityType *selectedType;
/**推出的菜单 */
@property (nonatomic, strong)ZZPopMenu *popmenu;
/**选择的菜单*/
@property (nonatomic, strong)ZZSelectorView *selectorView;

/***记录上一次请求参数*/
@property (nonatomic, strong)ZZActivityListParam *listParam;
/***记录上一次返回参数*/
@property (nonatomic, strong)ZZActivityListResult *listResult;

@property (nonatomic, strong)ZZEmptyView *emptyView;
@end

@implementation ZZActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZZViewBackColor;
    [self  setUpTableView];
}
//设置tableview的相关属性
- (void)setUpTableView{
    self.tableView.rowHeight = [ZZActivityCell  cellHeight];
    //一定要在tableview 分割线设置之前
    [self.tableView  registerNib:[UINib nibWithNibName:@"ZZActivityCell" bundle:nil] forCellReuseIdentifier:[ZZActivityCell   cellXibIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //底部刷新
    self.tableView.footer =   [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreService)];
    
    //头部刷新
    self.tableView.header =  [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    self.tableView.header.automaticallyChangeAlpha = YES;
    [self.tableView.header  beginRefreshing];
    
}
//设置筛选菜单
- (void)setUpSelectMenu{
    //城市
    ZZMenuButton *city = [[ZZMenuButton  alloc]init];
    [city setTitle:@"全部" forState:UIControlStateNormal];
    [city  addTarget:self action:@selector(cityMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cityMenuBtn = city;
    
    //类型
    ZZMenuButton *type = [[ZZMenuButton alloc]init];
    [type setTitle:@"全部" forState:UIControlStateNormal];
    [type  addTarget:self action:@selector(typeMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.typeMenuBtn = type;
    
    //状态
    ZZMenuButton *status = [[ZZMenuButton alloc]init];
    [status setTitle:@"全部" forState:UIControlStateNormal];
    [status  addTarget:self action:@selector(statusMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.statusMenuBtn = status;
}

#pragma  event response
//城市
- (void)cityMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;
    
    self.selectorView.datas= [ZZActivityCity arrays];
    self.selectorView.type = ZZSelectorTypeCity;
    self.popmenu.contentView = self.selectorView;
  //  self.popmenu.backgroundColor = [UIColor  redColor];
    [self.popmenu showFrom:button];
  
}
//类型
- (void)typeMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;

    self.selectorView.datas= [ZZActivityType arrays];
    self.selectorView.type = ZZSelectorTypeType;
    self.popmenu.contentView = self.selectorView;
  //  self.popmenu.backgroundColor = [UIColor  grayColor];
    [self.popmenu showFrom:button];
}
//状态
- (void)statusMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;
    
    self.selectorView.datas= [ZZActivityStatus arrays];
    self.selectorView.type = ZZSelectorTypeStatus;
   self.popmenu.contentView = self.selectorView;
   // self.popmenu.backgroundColor = [UIColor yellowColor];
    [self.popmenu showFrom:button];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 self.emptyView.hidden = (self.activityArray.count > 0);
    return self.activityArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZActivityCell *cell = [tableView  dequeueReusableCellWithIdentifier:[ZZActivityCell   cellXibIdentifier]  ];
    cell.activity = self.activityArray[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.topMenuView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.topMenuView.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZActivityDetailController *actDetailVC = [[ZZActivityDetailController  alloc]init];
    [self.navigationController  pushViewController:actDetailVC animated:YES];
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ZZPopMenuDelegate
-(void)popMenuDidDismissed:(ZZPopMenu *)popMenu{
     self.selectMenuBtn.selected = NO;
}
#pragma mark -ZZSelectorViewDlegate

-(void)selectorView:(ZZSelectorView *)selectorView selected:(id<ZZSelectorViewShowDele>)selectedObject type:(NSUInteger)type{
    [self.popmenu  dismiss];
    switch (type) {
        case ZZSelectorTypeCity:{
             self.selectedCity = (ZZActivityCity *)selectedObject;
            
        }
           
            break;
        case ZZSelectorTypeType:{
            self.selectedType = (ZZActivityType *)selectedObject;
        }
            
            break;
        case ZZSelectorTypeStatus:{
            self.selectedStatus = (ZZActivityStatus *) selectedObject;
        }
            
            break;
    }
    self.selectMenuBtn.selected = NO;
    [self.tableView.header  beginRefreshing];
}

#pragma mark -网络请求

- (void)getNetData{
    self.listResult = nil;
      [self.tableView.footer endRefreshing];
    ZZActivityListParam *listParam = [self  getListParam];

    [self.activityArray  removeAllObjects];
    [self.tableView  reloadData];
    [ZZActivityHttpTool  activityList:listParam success:^(ZZActivityListResult *listResult, ZZNetDataType netSuccType) {
        if (self.listParam != listParam) {
            return ;
        }
        [self.tableView.header endRefreshing];
        self.listResult = listResult;
        [self.activityArray  addObjectsFromArray:listResult.rows];
        [self.tableView  reloadData];
    } failure:^(NSString *error, ZZNetDataType netFailType) {
        [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self action:@selector(getNetData) isBack:NO];
      
        [self.tableView.header endRefreshing];
    }];
}

- (void)loadMoreService{
    ZZActivityListParam *listParam = [self  getListParam];
    [ZZActivityHttpTool  activityList:listParam success:^(ZZActivityListResult *listResult, ZZNetDataType netSuccType) {
        if (self.listParam != listParam) {
            return ;
        }
        [self.tableView.footer endRefreshing];
        self.listResult = listResult;
        [self.activityArray  addObjectsFromArray:listResult.rows];
        [self.tableView  reloadData];
    } failure:^(NSString *error, ZZNetDataType netFailType) {
        [ZZHudView  showMessage:@"刷新失败，稍候请再次上拉刷新" time:5 toView:self.view];
        [self.tableView.footer endRefreshing];
    }];
}

//获得网络请求参数
- (ZZActivityListParam *)getListParam{
    
    ZZActivityListParam *listParam = [[ZZActivityListParam  alloc]init];
    listParam.numberOfPerPage = @(ActivityNumCount);
    listParam.pageNo = @(self.listResult.page);
    if (self.selectedCity.cityNumber) {
        listParam.city = @(self.selectedCity.cityNumber);
    }
    if (self.selectedStatus.statusNumber != ZZActivityStatusTypeAll) {
        listParam.status = @(self.selectedStatus.statusNumber);
    }
    if (self.selectedType.typeNumber) {
        listParam.type = @(self.selectedType.typeNumber);
    }
    self.listParam = listParam;
    return listParam;
    
}
#pragma mark -lazy load

-(ZZEmptyView *)emptyView{
    if (_emptyView == nil) {
        _emptyView = [ZZEmptyView  emptyView];
        _emptyView.tipTitle = @"没有相关服务";
        _emptyView.yOffset = self.topMenuView.height;
        [self.view  addSubview:_emptyView];
    }
    return _emptyView;
}
-(void)setResult:(ZZActivityListResult *)listResult{
    _listResult = listResult;
    if (listResult.page == listResult.total) {
        [self.tableView.footer noticeNoMoreData];
    }else{
        [self.tableView.footer resetNoMoreData];
    }
}
-(NSMutableArray *)activityArray{
    if (_activityArray == nil) {
        _activityArray = [NSMutableArray array];
    }
    return _activityArray;
}
-(ZZTopMenuView *)topMenuView{
    if (_topMenuView == nil) {
        //设置tableview的头部
        _topMenuView = [[ZZTopMenuView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        _topMenuView.backgroundColor = [UIColor  whiteColor];
        if (self.cityMenuBtn == nil) {
            [self  setUpSelectMenu];
        }
        _topMenuView.menuButtons = @[self.cityMenuBtn,self.typeMenuBtn,self.statusMenuBtn];
    }
    return _topMenuView;
}

-(ZZPopMenu *)popmenu{
    if (_popmenu == nil) {
        _popmenu = [[ZZPopMenu alloc]init];
           _popmenu.dimBackground = YES;
        _popmenu.delegate = self;
        _popmenu.contentView = self.selectorView;
   }
    return _popmenu;
}
-(ZZSelectorView *)selectorView{
    if (_selectorView == nil) {
        _selectorView = [[ZZSelectorView  alloc]init];
        _selectorView.selecedDelegate = self;
    }
    return _selectorView;
}
@end
