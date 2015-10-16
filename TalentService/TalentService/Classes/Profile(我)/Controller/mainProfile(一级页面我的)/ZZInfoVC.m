//
//  ZZInfoVC.m
//  TalentService
//
//  Created by charles on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZInfoVC.h"
#import "ZZCommunityTVC.h"
#import "ZZAttentionVC.h"
#import "ZZMessageTVC.h"
#import "ZZMyOrderVC.h"
#import "ZZInfoDetailVC.h"
#import "ZZInfoModifyVC.h"
#import "ZZInfoCell.h"
#import "ZZJoinOrderTVC.h"
#import "ZZMyCollectVC.h"
#import "UUPhotoActionSheet.h"
#import "ZZMyAllActivityTVC.h"
#import "HCSStarRatingView.h"
#import "ZZMyInfoModel.h"
#import "ZZApplyVC.h"
#import "ZZMyGoldVC.h"
#import "LDProgressView.h"
#import "UIBarButtonItem+Extension.h"
#import "ZZMyEvaluationTVC.h"
/**
 *  我的页面请求
 */
#import "ZZMyInfoHttpTool.h"
#import "ZZLoginUser.h"

#import "ZZHeadImageView.h"

#import "ZZUploadImageModel.h"
@interface ZZInfoVC ()<UITableViewDataSource,UITableViewDelegate,UUPhotoActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@property (weak, nonatomic) IBOutlet ZZHeadImageView *headIV;

@property (weak, nonatomic) IBOutlet UIView *tableHeadView;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@property (strong, nonatomic) IBOutlet UIImageView *infoIV;


/** 选择图片*/
@property (nonatomic, strong) UUPhotoActionSheet *sheet;
@property (weak, nonatomic) IBOutlet LDProgressView *progressView;

@property (nonatomic, strong)NSArray *rowDatas;

@property (weak, nonatomic) IBOutlet UIImageView *introIV;

@end

@implementation ZZInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    
    
    //初始化tableview
    [self initTableView];
    //右Button
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem  itemWithTarget:self action:@selector(messageAction:) image:@"message2_30x30" highImage:nil];
    //左Button
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemWithTarget:self action:@selector(settingAction:) image:@"set_30x30" highImage:nil];
 
    //赋值
    [self selfInformation];
    //通知
    [self monitorNotification];
}


//tableview初始化
- (void)initTableView {
    if (ScreenWidth == 320) {
        self.tableHeadView.height = 440;
    } else if (ScreenWidth >375) {
        self.tableHeadView.height = 520;
    }
    
    self.infoTableView.tableHeaderView = self.tableHeadView;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib* nib = [UINib nibWithNibName:@"ZZInfoCell" bundle:nil];
    [self.infoTableView registerNib:nib forCellReuseIdentifier:infoCelldentifier];
    self.infoTableView.rowHeight = 50;
 
}

-(void)awakeFromNib{
    //星星
    self.tableHeadView.width = ScreenWidth;
    self.starView.maximumValue = 5;
    self.starView.minimumValue = 0;
    self.starView.allowsHalfStars = NO;
    self.starView.spacing = 5;
    self.starView.tintColor = ZZYellowColor;
    
    self.progressView.color = ZZNatiBarColor;
    self.progressView.flat = @YES;
    self.progressView.animate = @YES;
    self.progressView.showText = @NO;
    self.progressView.showStroke = @NO;
    self.progressView.progressInset = @5;
    self.progressView.showBackground = @NO;
    self.progressView.outerStrokeWidth = @3;
    self.progressView.type = LDProgressSolid;
}

//请求数据赋值
- (void)selfInformation {
    ZZLoginUser *user = ZZLoginTool.loginUser;
    self.nameLabel.text = user.userNike;
    self.infoIV.contentMode = UIViewContentModeScaleAspectFill;
    self.infoIV.clipsToBounds = YES;
    
    [self.infoIV setPictureImageWithURL:user.backgroundImg];
    if (user.backImgHeight>user.backImgWidth) {
        self.infoIV.transform = CGAffineTransformMakeRotation((M_PI*(0)/180.0));
    }
    [self.headIV setHeadImageWithURL:user.userSmallImg];
    //星星
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
    
  
    ZZUserRole *userRole = user.userRole[0];
    self.roleLabel.text = userRole.eredarName;
    self.fansCount.text = [NSString stringWithFormat:@"Fans(%ld)",user.fans];
    //经验值进度条
    self.progressView.progress = 0.40;
    
}

//监听通知
- (void)monitorNotification {
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice) name:ZZUserNickChangeNoti object:nil];
}

//通知方法
- (void)notice {
     ZZLoginUser *user = ZZLoginTool.loginUser;
    self.nameLabel.text = user.userNike;
    [self.headIV setHeadImageWithURL:user.userSmallImg];
    [self.infoIV setPictureImageWithURL:user.backgroundImg];
}


//右button响应事件
- (void)messageAction:(UIButton*)sender {
    ZZLog(@"消息消息");
    ZZMessageTVC *messageTvc = [[ZZMessageTVC alloc]init];
    [self.navigationController pushViewController:messageTvc animated:YES];
}

//左button响应事件
- (void)settingAction:(UIButton*)sender {
    ZZLog(@"设置设置");
    ZZInfoModifyVC *myselfInfoTvc = [[ZZInfoModifyVC alloc]init];
    [self.navigationController pushViewController:myselfInfoTvc animated:YES];
}

#pragma mark - UITableViewDatasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rowDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.rowDatas[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZInfoCell *cell = [tableView  dequeueReusableCellWithIdentifier:infoCelldentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZZMyInfoModel *model = self.rowDatas[indexPath.section][indexPath.row];
            cell.nameLabel.text = model.text;
            cell.imageIV.image = [UIImage imageNamed:model.iconName];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      ZZMyInfoModel *model = self.rowDatas[indexPath.section][indexPath.row];
           
    UIViewController *vc = [[model.classType alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)gotoChangeImage:(UIButton *)sender {
    ZZLog(@"换图换图");
    [self.sheet showAnimation];
}

- (void)actionSheetDidFinished:(NSArray *)obj {
    ZZUploadImageModel *imageModel = obj[0];
    self.infoIV.image = imageModel.image;
    [MBProgressHUD showMessage:@"正在保存中..."];
    [ZZMyInfoHttpTool commitBackgroundImageWithImageArray:obj success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showSuccess:@"保存成功" toView:self.view];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showError:error toView:self.view];
    }];
}

- (IBAction)gotoCollect:(UIButton *)sender {
    ZZLog(@"收藏收藏");
    ZZMyCollectVC *mycollectVc = [[ZZMyCollectVC alloc]initWithNib];
    [self.navigationController pushViewController:mycollectVc animated:YES];
}



- (IBAction)gotoAttentionView:(UIButton *)sender {
    ZZLog(@"关注关注");
    ZZAttentionVC *attentionVc = [[ZZAttentionVC alloc]initWithNib];
    [self.navigationController pushViewController:attentionVc animated:YES];
}

- (IBAction)didClickOnMyEvaluation:(UIButton *)sender {
    ZZLog(@"评价");
//    ZZMyEvaluationTVC *myEvaluationTvc = [[ZZMyEvaluationTVC alloc] initWithNib];
//    [self.navigationController pushViewController:myEvaluationTvc animated:YES];
}

#pragma mark -Setters and Getters

- (UUPhotoActionSheet *)sheet {
    if (_sheet == nil) {
        _sheet = [[UUPhotoActionSheet alloc] initWithWeakSuper:self];
        _sheet.delegate = self;
        _sheet.head = YES;
    }
    return _sheet;
}


-(NSArray *)rowDatas{
    if (_rowDatas == nil) {
        //第一个分区
        NSMutableArray *farray = [NSMutableArray  array];
        ZZMyInfoModel *order = [ZZMyInfoModel  myInfoModelWithText:@"我的订单" iconName:@"accept_40x40" classType:[ZZMyOrderVC class ]];
        [farray  addObject:order];
        ZZLoginUser *user = ZZLoginTool.loginUser;
        if (user.isEredar) {
            ZZMyInfoModel *serve = [ZZMyInfoModel  myInfoModelWithText:@"我的服务" iconName:@"accept_40x40" classType:[ZZMyAllActivityTVC class ]];
            [farray  addObject:serve];
        }
         //第二个分区
        NSMutableArray *tarray = [NSMutableArray  array];
        ZZMyInfoModel *comnumity = [ZZMyInfoModel  myInfoModelWithText:@"我的社区" iconName:@"community_40x40" classType:[ZZCommunityTVC class ]];
        [tarray  addObject:comnumity];
        ZZMyInfoModel *gold = [ZZMyInfoModel  myInfoModelWithText:@"我的金币" iconName:@"coin_40x40" classType:[ZZMyGoldVC class ]];
        [tarray  addObject:gold];
        
        ZZMyInfoModel *apply = [ZZMyInfoModel  myInfoModelWithText:@"申请达人" iconName:@"talent_40x40" classType:[ZZApplyVC class ]];
        [tarray  addObject:apply];
        
        _rowDatas = @[farray,tarray];
    }
    return _rowDatas;
}


@end
