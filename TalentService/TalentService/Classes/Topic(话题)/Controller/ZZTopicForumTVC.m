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

#import "ZZCommunityTypeVC.h"

@interface ZZTopicForumTVC ()<UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchView;
@property (nonatomic)NSInteger topicType;
@end

@implementation ZZTopicForumTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZZViewBackColor;
    UIButton *communityBT = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 22)];
    [communityBT setTitle:@"话题⬇️" forState:UIControlStateNormal];
    communityBT.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [communityBT addTarget:self action:@selector(didClickOnChooseType) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = communityBT;
    [self  setTableViewProperty];
    [self rigthNavigationItem];
    
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

- (void) getTopicType: (NSInteger)topicType {
    self.topicType = topicType;
    ZZLog(@"话题%ld",(long)self.topicType);
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
    if (ScreenWidth == 320) {
        self.tableView.rowHeight = 280;
    } else if (ScreenWidth == 375) {
        self.tableView.rowHeight = 300;
    } else {
        self.tableView.rowHeight = 315;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:communityCelldentifier forIndexPath:indexPath];
    return cell;
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
@end
