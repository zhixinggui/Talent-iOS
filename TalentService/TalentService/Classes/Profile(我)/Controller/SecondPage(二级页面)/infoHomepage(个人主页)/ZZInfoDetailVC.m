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
#import "LDProgressView.h"
#import "HCSStarRatingView.h"
#import "ZZActivityDetailController.h"

#define numberOfpage 10
@interface ZZInfoDetailVC ()<UITableViewDataSource,UITableViewDelegate,ZZSegmentedControlDelegate>

@property(nonatomic,strong)ZZOtherUser *loginUser;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *infoDetailTableView;
@property (weak, nonatomic) IBOutlet UIImageView *backGroungIV;
@property (strong, nonatomic) ZZSegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansNumLabel;


@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
@property (nonatomic, strong)NSMutableArray *activityArray;
@property (weak, nonatomic) IBOutlet LDProgressView *progressView;
@property (nonatomic, strong)ZZHomeServiceResult *result;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *introductionLabelHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *introBackgroundHeight;

@end

@implementation ZZInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"个人主页";
    [self  setInterface];
}
/**设置属性*/
- (void)setInterface{
    UINib* nib = [UINib nibWithNibName:@"ZZActivityCell" bundle:nil];
    [self.infoDetailTableView registerNib:nib forCellReuseIdentifier:[ZZActivityCell   cellXibIdentifier]];
    self.infoDetailTableView.delegate = self;
    self.infoDetailTableView.dataSource = self;
    self.infoDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.infoDetailTableView.rowHeight = [ZZActivityCell  cellHeight];
    if (ScreenWidth == 320) {
        self.headView.height = 390;
    } else if (ScreenWidth >375) {
        self.headView.height = 460;
    }
    self.infoDetailTableView.tableHeaderView = self.headView;
    //底部刷新
    self.infoDetailTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreService)];
    //请求用户信息
    [self getUserInfoNetData];
    //星星
    [self getStarStar];
}

- (void)getStarStar {
    self.starView.maximumValue = 5;
    self.starView.minimumValue = 0;
    self.starView.allowsHalfStars = NO;
    self.starView.spacing = 5;

    self.starView.tintColor = ZZYellowColor;
    self.starView.value = 1;
    self.progressView.color = ZZNatiBarColor;
    self.progressView.flat = @YES;
    self.progressView.animate = @YES;
    self.progressView.showText = @NO;
    self.progressView.showStroke = @NO;
    self.progressView.progressInset = @3;
    self.progressView.showBackground = @NO;
    self.progressView.outerStrokeWidth = @1;
    self.progressView.type = LDProgressStripes;
    self.progressView.progress = 0.40;
}
/**
 *  请求用户信息
 */
- (void)getUserInfoNetData {
    [ZZMyInfoHttpTool getMyInfoWithUserAttentionId:@(self.userAttentionId) andMyCenter:@(1) success:^(ZZOtherUser *infoUser, ZZNetDataType dataType) {
        self.loginUser = infoUser;
        ZZLog(@"你妹啊infoUser:%ld",(unsigned long)self.loginUser.userId);
        [self.headIV  setHeadImageWithURL:infoUser.userSmallImg];
        self.backGroungIV.contentMode = UIViewContentModeScaleAspectFill;
        self.backGroungIV.clipsToBounds = YES;
        [self.backGroungIV setPictureImageWithURL:infoUser.backgroundImg];
        self.nameLabel.text = self.loginUser.userNike;
        self.fansNumLabel.text = [NSString stringWithFormat:@"Fans(%ld)",self.loginUser.fans];
        self.introductionLabel.text = self.loginUser.userPresentation;
        CGSize introSize = [self.introductionLabel.text sizeWithFont:[UIFont systemFontOfSize:14] maxW:ScreenWidth-20];
        self.introductionLabelHeight.constant = introSize.height;
        self.introBackgroundHeight.constant = introSize.height+10;
        if (!self.loginUser.userPresentation.length) {
            self.introBackgroundHeight.constant = 0;
        }
        ZZUserRole *userRole = self.loginUser.userRole[0];
        self.identityLabel.text = userRole.eredarName;
        if (self.loginUser.userId == [ZZLoginUserTool sharedZZLoginUserTool].loginUser.userId) {
            self.attentionButton.hidden = YES;
        }else{
            self.attentionButton.hidden = NO;
        }
        if (self.loginUser.isAttention) {
            self.attentionButton.selected = YES;
        }else{
            self.attentionButton.selected = NO;
        }
        [self getMyCollectionList];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.segmentControl;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZActivity * activity = self.activityArray[indexPath.row];
    ZZActivityDetailController *detailViewController = [[ZZActivityDetailController alloc] init];
    detailViewController.activityId =  activity.activityId;
    [self.navigationController pushViewController:detailViewController animated:YES];
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
            //取消关注通知
            NSNotification * noti = [NSNotification  notificationWithName:ZZMyAttentionNoti object:nil];
            [[NSNotificationCenter  defaultCenter]postNotification:noti];
            
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
    if (self.loginUser.isEredar) {
        myServiceparam.isEredar = @(1);
    }else {
        myServiceparam.isEredar = @(0);
    }
    myServiceparam.userId = @(self.userAttentionId);
    myServiceparam.numberOfPerPage = @(numberOfpage);
    myServiceparam.pageNo = @(0);
    [ZZMyInfoHttpTool getmyServiceListWithMyServiceParam:myServiceparam success:^(ZZHomeServiceResult *result, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUDForView:self.view];
        ZZLog(@"啥数据啊:%@",result);
        self.result = result;
        [self.activityArray  removeAllObjects];
        [self.activityArray addObjectsFromArray:result.rows];
        [self.infoDetailTableView reloadData];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUDForView:self.view];
        [MBProgressHUD  showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.infoDetailTableView target:self action:@selector(getMyCollectionList) isBack:NO];
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
    myServiceparam.myCenter = @(0);
    if (self.loginUser.isEredar) {
        myServiceparam.isEredar = @(1);
    }else {
        myServiceparam.isEredar = @(0);
    }
    myServiceparam.userId = @(self.userAttentionId);
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
        _segmentControl = [[ZZSegmentedControl alloc]initWithItems:@[@"TA的服务"]];
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
