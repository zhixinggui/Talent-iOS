//
//  ZZTopicForumTVC.m
//  TalentService
//
//  Created by zhizhen on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicForumTVC.h"
#import "ZZCommunityCell.h"
#import "ZZPublishTopicVC.h"
#import "ZZSIzeFitButton.h"
#import "ZZTopicDetailVC.h"
#import "ZZTopicSearchVC.h"
#import "ZZTopicHtttpTool.h"
#import "ZZCommunityTypeVC.h"
#import "MJRefresh.h"
#import "ZZHudView.h"
#define labelHeight 43
#define imageHeight (ScreenWidth - 50)/3
@interface ZZTopicForumTVC ()<UISearchBarDelegate,topicTypeDelegete>

@property (strong, nonatomic) UISearchBar *searchView;

@property (strong, nonatomic) UIButton *communityBT;

@property (strong, nonatomic) NSMutableArray *topicListArray;

@property (nonatomic, strong)ZZTopicResult *topicResult;
@end

@implementation ZZTopicForumTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZZViewBackColor;
    self.communityBT = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 22)];
    [self.communityBT setTitle:@"话题⬇️" forState:UIControlStateNormal];
    self.communityBT.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.communityBT addTarget:self action:@selector(didClickOnChooseType) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.communityBT;
    [self  setTableViewProperty];
    [self rigthNavigationItem];
    [self getNetDataTopicListWithTopicType:@""];
}
/**话题请求*/
- (void)getNetDataTopicListWithTopicType:(NSString *)topicType {
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    ZZTopicParam *topicParam = [[ZZTopicParam alloc]init];
    topicParam.topicType = @"";
    topicParam.numberOfPerPage = @(10);
    topicParam.pageNo = @(0);
    [ZZTopicHtttpTool topicListWithTopicType:topicParam Success:^(ZZTopicResult *topicResult, ZZNetDataType netDataType) {
        [MBProgressHUD  hideHUDForView:self.view];
        self.topicResult = topicResult;
        [self.topicListArray addObjectsFromArray:topicResult.rows];
        [self.tableView reloadData];
    } failure:^(NSString *error, ZZNetDataType dataType) {
        [self.tableView.footer  endRefreshing];
        [ZZHudView  showMessage:error time:3 toView:self.view];
    }];
}


- (void)rigthNavigationItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem  alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(publishTopic)];
}
//选择话题
- (void)didClickOnChooseType {
    ZZLog(@"选择话题");
    
    ZZCommunityTypeVC *communityTypeVc = [[ZZCommunityTypeVC alloc]initWithNib];
    communityTypeVc.delegate = self;
    [self.navigationController pushViewController:communityTypeVc animated:YES];
}

- (void) getTopicType: (ZZTopicType *)topicType {

    [self.communityBT setTitle:topicType.name];
}

/**发布新话题*/
- (void)publishTopic{
    ZZPublishTopicVC *pvc = [[ZZPublishTopicVC  alloc]init];
    [self.navigationController  pushViewController:pvc animated:YES];
 //  pushVC(ZZPublishTopicVC);
}
//tableview的属性
- (void)setTableViewProperty{
    UINib* nib = [UINib nibWithNibName:@"ZZCommunityCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:communityCelldentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

//    //底部刷新
//    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getNetDataTopicListWithTopicType:)];
//    
//    //头部刷新
//    self.tableView.header =  [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetDataTopicListWithTopicType:)];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:communityCelldentifier forIndexPath:indexPath];
    cell.topic = self.topicListArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTopic *topic = self.topicListArray[indexPath.row];
   if (topic.contents && !topic.topicImgList.count) {
        return 192;
    } else if (!topic.contents && topic.topicImgList.count) {
        return 150 + imageHeight;
    } else {
        return 192 + imageHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView  deselectRowAtIndexPath:indexPath animated:YES];

    ZZTopicDetailVC *communityTvc = [[ZZTopicDetailVC alloc]initWithNib];
    [self.navigationController pushViewController:communityTvc animated:YES];

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.searchView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    ZZTopicSearchVC *topicSearchVC = [[ZZTopicSearchVC  alloc]init];
    [self.navigationController  pushViewController:topicSearchVC animated:YES];
    return NO;
}
#pragma mark - set or get
-(UISearchBar *)searchView{
    if (_searchView == nil) {
        _searchView = [[UISearchBar alloc]init];
        _searchView.placeholder = @"搜索";
        _searchView.delegate = self;
       // _searchView.prompt = @"搜索";
    }
    return _searchView;
}

- (NSMutableArray *)topicListArray {
    if (!_topicListArray) {
        _topicListArray = [NSMutableArray  array];
    }
    return _topicListArray;
}

- (void)setTopicResult:(ZZTopicResult *)topicResult {
    _topicResult = topicResult;
    if (topicResult.page == topicResult.total) {
        [self.tableView.footer endRefreshingWithNoMoreData];
    }else{
        [self.tableView.footer resetNoMoreData];
    }
}
@end
