//
//  ZZInfoDetailVC.m
//  TalentService
//
//  Created by charles on 15/9/6.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZInfoDetailVC.h"
#import "ZZActivityCell.h"
#import "ZZSegmentedControl.h"
#import "ZZCommunityTVC.h"
#import "ZZActivityController.h"
/**
 *  个人页面请求
 */
#import "ZZMyInfoHttpTool.h"
#import "ZZOtherUser.h"
#import "MJRefresh.h"
#import "ZZHudView.h"
#import "ZZCollectParam.h"

#define numberOfpage 10
@interface ZZInfoDetailVC ()<UITableViewDataSource,UITableViewDelegate,ZZSegmentedControlDelegate>
@property(nonatomic,strong)ZZOtherUser *loginUser;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *infoDetailTableView;
@property (weak, nonatomic) IBOutlet UIImageView *backGroungIV;
@property (strong, nonatomic) ZZSegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
@property (nonatomic, strong)NSMutableArray *activityArray;
@property (nonatomic, strong)ZZHomeServiceResult *result;
@end

@implementation ZZInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人主页";
    UINib* nib = [UINib nibWithNibName:@"ZZActivityCell" bundle:nil];
    [self.infoDetailTableView registerNib:nib forCellReuseIdentifier:[ZZActivityCell   cellXibIdentifier]];
    self.infoDetailTableView.delegate = self;
    self.infoDetailTableView.dataSource = self;
    self.infoDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.infoDetailTableView.rowHeight = [ZZActivityCell  cellHeight];
    self.infoDetailTableView.tableHeaderView = self.headView;
    
    
    //底部刷新
    self.infoDetailTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreService)];
    
    //进入界面请求刷新
    [self getMyCollectionList];
    //请求用户信息
    [self getUserInfoNetData];
    
}

/**
 *  请求用户信息
 */
- (void)getUserInfoNetData {
    [ZZMyInfoHttpTool getMyInfoWithUserAttentionId:@(self.userAttentionId) andMyCenter:@(1) success:^(ZZOtherUser *infoUser, ZZNetDataType dataType) {
        ZZLog(@"个人信息infoUser:%@",infoUser);
        self.loginUser = infoUser;
        [self.headIV  setHeadImageWithURL:infoUser.userSmallImg];
        self.backGroungIV.contentMode = UIViewContentModeScaleAspectFill;
        self.backGroungIV.clipsToBounds = YES;
        [self.backGroungIV setPictureImageWithURL:infoUser.backgroundImg];
        self.nameLabel.text = self.loginUser.userNike;
        ZZUserRole *userRole = self.loginUser.userRole[0];
        self.identityLabel.text = userRole.eredarName;
        
        if (self.loginUser.isAttention) {
            self.attentionButton.selected = YES;
        }else{
            self.attentionButton.selected = NO;
        }
        
    } failure:^(NSString *error, ZZNetDataType datatype) {
        ZZLog(@"请求失败");
    }];
}

#pragma mark -tableViewDelegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.activityArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZZActivityCell   cellXibIdentifier] forIndexPath:indexPath];
    cell.activity = self.activityArray[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.segmentControl;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

#pragma mark  event delegate
-(void)segmentControl:(ZZSegmentedControl *)segment andIndex:(NSUInteger)index{
    ZZLog(@"切换%ld",index);
    switch (index) {
        case 0:
        {
            
        }
            break;
            
        case 1:
        {
            
        }
            break;
    }
}
/**
 *  关注事件
 */
- (IBAction)addAttention:(UIButton *)sender {
    self.attentionButton.enabled = NO;
    [ZZMyInfoHttpTool attentionOrCancelWithUserAttentionId:self.userAttentionId success:^(ZZOtherUser *otherUser, ZZNetDataType dataType) {
        sender.selected = !sender.selected;
        self.attentionButton.enabled = YES;
        if (sender.selected) {
            [MBProgressHUD  showSuccess:@"关注成功"];
        }else{
            [MBProgressHUD  showSuccess:@"取消关注"];
        }
        
    } failure:^(NSString *error, ZZNetDataType datatype) {
        ZZLog(@"数据返回失败");
        [MBProgressHUD  showError:error];
    }];
}

/**
 *  进入界面请求刷新
 */
-(void)getMyCollectionList{
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    ZZMyServiceParam *myServiceparam = [[ZZMyServiceParam alloc]init];
    myServiceparam.myCenter = @(0);
    
    myServiceparam.isEredar = @(self.isEredar);
    if ([myServiceparam.myCenter isEqualToNumber:@(1)]) {
        
    }else{
        myServiceparam.userId = @(self.userAttentionId);
    }
    myServiceparam.numberOfPerPage = @(numberOfpage);
    myServiceparam.pageNo = @(0);
    [ZZMyInfoHttpTool getmyServiceListWithMyServiceParam:myServiceparam success:^(ZZHomeServiceResult *result, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUDForView:self.view];
        ZZLog(@"啥数据啊:%@",result);
        self.result = result;
//        if (self.result.rows.count == 0) {
//            
//            [MBProgressHUD showMessageClearBackView:@"你还没有服务" toView:self.infoDetailTableView ];
//        }
        [self.activityArray  removeAllObjects];
        [self.activityArray addObjectsFromArray:result.rows];
        [self.infoDetailTableView reloadData];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUDForView:self.view];
        [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self action:@selector(getMyCollectionList) isBack:NO];
    }];
}

/**
 *  底部刷新方法
 */
- (void)loadMoreService{
    [self getMoreCollectionList];
}
/**
 *  底部刷新更多请求
 */
- (void)getMoreCollectionList{
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
        [self.infoDetailTableView.footer endRefreshing];
        ZZLog(@"啥数据啊:%@",result);
        self.result = result;
        [self.activityArray addObjectsFromArray:result.rows];
        [self.infoDetailTableView reloadData];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [self.infoDetailTableView.footer  endRefreshing];
        [ZZHudView  showMessage:error time:3 toView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Setter andGetters
-(ZZSegmentedControl *)segmentControl{
    if (!_segmentControl) {
        _segmentControl = [[ZZSegmentedControl alloc]initWithItems:@[@"服务"]];
        _segmentControl.delegate = self;
        _segmentControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    }
    return _segmentControl;
}
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
        [self.infoDetailTableView.footer noticeNoMoreData];
    }else{
        [self.infoDetailTableView.footer resetNoMoreData];
    }
}
@end
