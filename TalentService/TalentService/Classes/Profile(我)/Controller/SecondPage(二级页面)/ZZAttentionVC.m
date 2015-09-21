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
@interface ZZAttentionVC ()<UITableViewDelegate,UITableViewDataSource,ZZSegmentedControlDelegate>
@property (weak, nonatomic) IBOutlet UITableView *attentionTV;
@property(nonatomic,strong)ZZSegmentedControl *attentionSegmentedControl;
@property(nonatomic,strong)ZZAttentionResult *attResult;
@property(nonatomic,strong)NSArray *attentionArray;
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
    [self getNetWithAttentionListWithTypeNum:0 andPageNo:0 andNumberOfPerPage:20];
}

-(void)getNetWithAttentionListWithTypeNum:(NSInteger)typeNum andPageNo:(NSInteger)pageNo andNumberOfPerPage:(NSInteger)numberOfPerPage{
    /**
     *  获取关注列表
     */
    [ZZMyInfoHttpTool getMyAttentionWithTypeNum:typeNum andPageNo:pageNo andNumberOfPerPage:numberOfPerPage success:^(ZZAttentionResult *attResult, ZZNetDataType dataType) {
        self.attResult = attResult;
        self.attentionArray = self.attResult.rows;
        [self.attentionTV reloadData];
        ZZLog(@"数组长度:%ld",self.attentionArray.count);
    } failure:^(NSString *error, ZZNetDataType datatype) {
        ZZLog(@"没有返回数据");
    }];
}
#pragma mark - UITableViewDatasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.attentionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZAttentionCell *cell = [tableView  dequeueReusableCellWithIdentifier:attentionCelldentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.otherUser = self.attentionArray[indexPath.row];
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
    ZZOtherUser *otherUser = self.attentionArray[indexPath.row];
    infoDetailVc.userAttentionId = otherUser.userId;
    [self.navigationController pushViewController:infoDetailVc animated:YES];
}

#pragma mark ZZSegmentedControlDelegate

- (void)segmentControl:(ZZSegmentedControl *)segment andIndex:(NSUInteger)index{
    switch (index) {
        case 0:
        {
            [self getNetWithAttentionListWithTypeNum:0 andPageNo:0 andNumberOfPerPage:20];
        }
            break;
            
        case 1:
        {
            [self getNetWithAttentionListWithTypeNum:1 andPageNo:0 andNumberOfPerPage:20];
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

-(NSArray *)attentionArray{
    if (!_attentionArray) {
        _attentionArray = [NSArray array];
    }
    return _attentionArray;
}

@end
