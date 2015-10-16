//
//  ZZAttentionVC.m
//  TalentService
//
//  Created by charles on 15/8/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZAttentionVC.h"
#import "ZZSegmentedControl.h"
#import "ZZAttentionCell.h"
#import "ZZMyInfoHttpTool.h"
#import "ZZInfoDetailVC.h"
#import "MJRefresh.h"
#import "ZZHudView.h"

#import "ZZAttentionParam.h"


#define numberOfpage 10
@interface ZZAttentionVC ()<UITableViewDelegate,UITableViewDataSource,ZZSegmentedControlDelegate>
@property (weak, nonatomic) IBOutlet UITableView *attentionTV;
@property(nonatomic,strong)ZZSegmentedControl *attentionSegmentedControl;
@property(nonatomic,strong)ZZAttentionResult *attResult;
@property(nonatomic,strong)NSMutableArray *attentionArray;
@property(nonatomic,strong)NSMutableArray *expertArray;
@property(nonatomic)NSUInteger segmentIndex;
@end

@implementation ZZAttentionVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    self.attentionTV.delegate = self;
    self.attentionTV.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"ZZAttentionCell" bundle:nil];
    [self.attentionTV registerNib:nib forCellReuseIdentifier:attentionCelldentifier];
    self.attentionTV.rowHeight = 100;
    self.attentionTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //底部刷新
    self.attentionTV.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreService)];
    
    //头部刷新
    [self getNetWithAttentionListWithTypeNum:0];
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
            //[MBProgressHUD showMessageClearBackView:@"你还没有关注任何朋友" toView:self.view];
        }
        if (typeNum) {
            [self.expertArray removeAllObjects];
            [self.expertArray addObjectsFromArray:self.attResult.rows];
        }else{
            [self.attentionArray removeAllObjects];
            [self.attentionArray addObjectsFromArray:self.attResult.rows];
        }
        [self.attentionTV reloadData];
        ZZLog(@"数组长度:%ld",self.attResult.rows.count);
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
        if (typeNum) {
            [self.expertArray addObjectsFromArray:self.attResult.rows];
        }else{
            [self.attentionArray addObjectsFromArray:self.attResult.rows];
        }
        [self.attentionTV reloadData];
        ZZLog(@"数组长度:%ld",self.attentionArray.count);
    } failure:^(NSString *error, ZZNetDataType datatype) {
        ZZLog(@"没有返回数据");
        [self.attentionTV.footer endRefreshing];
        [ZZHudView  showMessage:error time:3 toView:self.view];
    }];
}



#pragma mark - UITableViewDatasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.segmentIndex) {
        return self.expertArray.count;
    }else{
        return self.attentionArray.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZAttentionCell *cell = [tableView  dequeueReusableCellWithIdentifier:attentionCelldentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.segmentIndex) {
        cell.otherUser = self.expertArray[indexPath.row];
    }else{
        cell.otherUser = self.attentionArray[indexPath.row];
    }
    
    ZZLog(@"数据:%@",cell.otherUser);
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.attentionSegmentedControl;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZInfoDetailVC *infoDetailVc = [[ZZInfoDetailVC alloc]initWithNib];
    if (self.segmentIndex) {
        ZZOtherUser *otherUser = self.expertArray[indexPath.row];
        infoDetailVc.userAttentionId = otherUser.userId;
        infoDetailVc.isEredar = otherUser.isEredar;
    }else{
        ZZOtherUser *otherUser = self.attentionArray[indexPath.row];
        infoDetailVc.userAttentionId = otherUser.userId;
        infoDetailVc.isEredar = otherUser.isEredar;
    }
    [self.navigationController pushViewController:infoDetailVc animated:YES];
}

#pragma mark ZZSegmentedControlDelegate

- (void)segmentControl:(ZZSegmentedControl *)segment andIndex:(NSUInteger)index{
    self.segmentIndex  = index;
    switch (index) {
        case 0:
        {
            [self getNetWithAttentionListWithTypeNum:self.segmentIndex];
        }
            break;
            
        case 1:
        {
            [self getNetWithAttentionListWithTypeNum:self.segmentIndex];
        }
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark setter andGetter
-(ZZSegmentedControl *)attentionSegmentedControl{
    if (!_attentionSegmentedControl) {
        _attentionSegmentedControl = [[ZZSegmentedControl alloc]initWithItems:@[@"朋友",@"达人"]];
        _attentionSegmentedControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
        _attentionSegmentedControl.delegate = self;
    }
    return _attentionSegmentedControl;
}

-(NSMutableArray *)attentionArray{
    if (!_attentionArray) {
        _attentionArray = [NSMutableArray array];
    }
    return _attentionArray;
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
        [self.attentionTV.footer noticeNoMoreData];
    }else{
        [self.attentionTV.footer resetNoMoreData];
    }
}


@end
