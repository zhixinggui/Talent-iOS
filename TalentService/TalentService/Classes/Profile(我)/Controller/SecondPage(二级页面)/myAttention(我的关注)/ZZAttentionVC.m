//
//  ZZAttentionVC.m
//  TalentService
//
//  Created by charles on 15/8/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZAttentionVC.h"
#import "ZZEmptyView.h"
#import "ZZSegmentedControl.h"
#import "ZZAttentionCell.h"
#import "ZZMyInfoHttpTool.h"
#import "ZZInfoDetailVC.h"
#import "MJRefresh.h"
#import "ZZHudView.h"


#import "ZZAttentionParam.h"


#define numberOfpage 10
@interface ZZAttentionVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *attentionTV;
@property (nonatomic, strong)ZZAttentionResult *attResult;
@property (nonatomic, strong)NSMutableArray *expertArray;
@property (nonatomic, strong)ZZEmptyView *emptyView;
@end

@implementation ZZAttentionVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    self.attentionTV.delegate = self;
    self.attentionTV.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"ZZAttentionCell" bundle:nil];
    [self.attentionTV registerNib:nib forCellReuseIdentifier:attentionCelldentifier];
    self.attentionTV.rowHeight = 82;
    self.attentionTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //底部刷新
    self.attentionTV.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreService)];
    
    //头部刷新
    [self getNetWithAttentionListWithTypeNum:self.segmentIndex];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice) name:ZZMyAttentionNoti object:nil];
}

- (void)notice {
    [self getNetWithAttentionListWithTypeNum:self.segmentIndex];
}

-(void)getNetWithAttentionListWithTypeNum:(NSInteger)typeNum{
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    /**
     *  获取关注列表
     */
    ZZAttentionParam *attentionParam = [[ZZAttentionParam alloc]init];
    attentionParam.typeNum = @(typeNum);
    attentionParam.pageNo = @(0);
    attentionParam.numberOfPerPage = @(numberOfpage);
    [ZZMyInfoHttpTool getMyAttentionWithAttentionParam:attentionParam success:^(ZZAttentionResult *attResult, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUDForView:self.view];
        self.attResult = attResult;
        if (self.attResult.rows.count == 0) {
            self.emptyView.hidden = NO;
        }else {
            self.emptyView.hidden = YES;
        }
        [self.expertArray removeAllObjects];
        [self.expertArray addObjectsFromArray:self.attResult.rows];
        [self.attentionTV reloadData];
        ZZLog(@"数组长度:%ld",(unsigned long)self.attResult.rows.count);
    } failure:^(NSString *error, ZZNetDataType datatype) {
        ZZLog(@"没有返回数据");
        [MBProgressHUD  hideHUDForView:self.view];
        [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self action:@selector(getNetWithAttentionListAgainWithTypeNum) isBack:NO];
    }];
}

//重新请求
- (void)getNetWithAttentionListAgainWithTypeNum {
    [self getNetWithAttentionListWithTypeNum:self.segmentIndex];
}

/**
 *  底部刷新方法
 */
- (void)loadMoreService{
    [self getMoreAttentionListWithTypeNum:self.segmentIndex];
}

-(void)getMoreAttentionListWithTypeNum:(NSInteger)typeNum{
    ZZAttentionParam *attentionParam = [[ZZAttentionParam alloc]init];
    attentionParam.typeNum = @(typeNum);
    attentionParam.pageNo = @(self.attResult.page);
    attentionParam.numberOfPerPage = @(numberOfpage);
    [ZZMyInfoHttpTool getMyAttentionWithAttentionParam:attentionParam success:^(ZZAttentionResult *attResult, ZZNetDataType dataType) {
       [self.attentionTV.footer endRefreshing];
        self.attResult = attResult;
        [self.expertArray addObjectsFromArray:self.attResult.rows];
        [self.attentionTV reloadData];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        ZZLog(@"没有返回数据");
        [self.attentionTV.footer endRefreshing];
        [ZZHudView  showMessage:error time:3 toView:self.view];
    }];
}

#pragma mark - UITableViewDatasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.expertArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZAttentionCell *cell = [tableView  dequeueReusableCellWithIdentifier:attentionCelldentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.otherUser = self.expertArray[indexPath.row];
    ZZLog(@"数据:%@",cell.otherUser);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZInfoDetailVC *infoDetailVc = [[ZZInfoDetailVC alloc]initWithNib];
    ZZOtherUser *otherUser = self.expertArray[indexPath.row];
    infoDetailVc.userAttentionId = otherUser.userId;
    infoDetailVc.isEredar = otherUser.isEredar;
    [self.navigationController pushViewController:infoDetailVc animated:YES];
}

#pragma mark setter andGetter

-(ZZEmptyView *)emptyView{
    if (_emptyView == nil) {
        _emptyView = [ZZEmptyView  emptyView];
        _emptyView.tipTitle = @"没有关注别人";
       _emptyView.frame = CGRectMake(0, 0 , ScreenWidth, ScreenHeight-44 -64);
        [self.view  addSubview:_emptyView];
    }
    return _emptyView;
}

-(NSMutableArray *)expertArray{
    if (!_expertArray) {
        _expertArray = [NSMutableArray array];
    }
    return _expertArray;
}

-(void)setAttResult:(ZZAttentionResult *)attResult{
    _attResult = attResult;
    if (attResult.page == attResult.total) {
        [self.attentionTV.footer endRefreshingWithNoMoreData];
    }else{
        [self.attentionTV.footer resetNoMoreData];
    }
}

-(void)dealloc{
    [[NSNotificationCenter  defaultCenter]removeObserver:self ];
}
@end
