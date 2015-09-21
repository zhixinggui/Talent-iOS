//
//  ZZInfoVC.m
//  TalentService
//
//  Created by charles on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZInfoVC.h"
#import "ZZMyEventVC.h"
#import "ZZCommunityTVC.h"
#import "ZZAttentionVC.h"
#import "ZZMessageTVC.h"
#import "ZZMyOrderTVC.h"
#import "ZZInfoDetailVC.h"
#import "ZZInfoModifyVC.h"
#import "ZZInfoCell.h"
#import "ZZJoinOrderTVC.h"
#import "ZZMyCollectVC.h"
#import "UUPhotoActionSheet.h"
#import "ZZMyAllActivityTVC.h"
/**
 *  我的页面请求
 */
#import "ZZMyInfoHttpTool.h"
#import "ZZLoginUser.h"
@interface ZZInfoVC ()<UITableViewDataSource,UITableViewDelegate,UUPhotoActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@property (nonatomic,strong)ZZLoginUser *loginUser;
@property (weak, nonatomic) IBOutlet UIView *tableHeadView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@property (strong, nonatomic) IBOutlet UIImageView *infoIV;
/** 选择图片*/
@property (nonatomic, strong) UUPhotoActionSheet *sheet;
@property (nonatomic,strong)NSArray *nameArray;
@property (nonatomic,strong)NSArray *imageArray;
@end

@implementation ZZInfoVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /**
     *  请求
     */
    [ZZMyInfoHttpTool getMyInfoWithUserAttentionId:nil andMyCenter:nil success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        ZZLog(@"个人信息infoUser:%@",infoUser);
        
    } failure:^(NSString *error, ZZNetDataType datatype) {
        ZZLog(@"请求失败");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoTableView.tableHeaderView = self.tableHeadView;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib* nib = [UINib nibWithNibName:@"ZZInfoCell" bundle:nil];
    [self.infoTableView registerNib:nib forCellReuseIdentifier:infoCelldentifier];
    self.infoTableView.rowHeight = 50;
    
    [self setNavRightItemWithName:@"消息" target:self action:@selector(messageAction:)];
    
    [self setNavLeftItemWithName:@"设置" target:self action:@selector(settingAction:)];
    /**
     *  请求数据赋值
     */
    self.nameLabel.text = self.loginUser.userNike;
    ZZUserRole *userRole = self.loginUser.userRole[0];
    self.roleLabel.text = userRole.eredarName;
    self.fansCount.text = [NSString stringWithFormat:@"%ld",self.loginUser.fans];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice) name:ZZUserNickChangeNoti object:nil];
}

-(void)notice{
    self.nameLabel.text = self.loginUser.userNike;
}

/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
/**
 *  navigation左button
 */
- (void)setNavLeftItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}


-(void)messageAction:(UIButton*)sender{
    ZZLog(@"消息消息");
    ZZMessageTVC *messageTvc = [[ZZMessageTVC alloc]initWithNib];
    [self.navigationController pushViewController:messageTvc animated:YES];
}

-(void)settingAction:(UIButton*)sender{
    ZZLog(@"设置设置");
    ZZInfoModifyVC *myselfInfoTvc = [[ZZInfoModifyVC alloc]initWithNib];
    [self.navigationController pushViewController:myselfInfoTvc animated:YES];
}



#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZInfoCell *cell = [tableView  dequeueReusableCellWithIdentifier:infoCelldentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            cell.nameLabel.text = self.nameArray[indexPath.row];
            cell.imageIV.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
        }
        break;
        
        case 1:
        {
            cell.nameLabel.text = self.nameArray[2];
            cell.imageIV.image = [UIImage imageNamed:self.imageArray[2]];
        }
        break;
        
        case 2:
        {
            cell.nameLabel.text = self.nameArray[3];
            cell.imageIV.image = [UIImage imageNamed:self.imageArray[3]];
        }
        break;
        
        case 3:
        {
            cell.nameLabel.text = self.nameArray[4];
            cell.imageIV.image = [UIImage imageNamed:self.imageArray[4]];
        }
        break;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            
            if (indexPath.row) {
                ZZLog(@"接单接单");
                ZZMyAllActivityTVC *myActivityTvc = [[ZZMyAllActivityTVC alloc]initWithNib];
                [self.navigationController pushViewController:myActivityTvc animated:YES];
            }else{
                ZZLog(@"订单订单");
                ZZMyOrderTVC *orderTvc = [[ZZMyOrderTVC alloc]initWithNib];
                [self.navigationController pushViewController:orderTvc animated:YES];
            }
            
        }
        break;
        
        case 1:
        {
            
        }
        break;
        
        case 2:
        {
            
        }
        break;
        
        case 3:
        {
            
        }
        break;
    }
    
}

- (IBAction)gotoChangeImage:(UIButton *)sender {
    ZZLog(@"换图换图");
    [self.sheet showAnimation];
    
}

- (void)actionSheetDidFinished:(NSArray *)obj{
    
    self.infoIV.image = obj[0];
    
}
- (IBAction)gotoCollect:(UIButton *)sender {
    ZZLog(@"收藏收藏");
    ZZMyCollectVC *mycollectVc = [[ZZMyCollectVC alloc]initWithNib];
    [self.navigationController pushViewController:mycollectVc animated:YES];
}

- (IBAction)gotoEvent:(UIButton *)sender {
    ZZLog(@"活动活动");
    ZZMyEventVC *myEventVc = [[ZZMyEventVC alloc]initWithNib];
    [self.navigationController pushViewController:myEventVc animated:YES];
}


- (IBAction)gotoCommunity:(UIButton *)sender {
    ZZLog(@"社区社区");
    ZZCommunityTVC *communityTvc = [[ZZCommunityTVC alloc]initWithNib];
    [self.navigationController pushViewController:communityTvc animated:YES];
}

- (IBAction)gotoAttentionView:(UIButton *)sender {
    ZZLog(@"关注关注");
    ZZAttentionVC *attentionVc = [[ZZAttentionVC alloc]initWithNib];
    [self.navigationController pushViewController:attentionVc animated:YES];
}

#pragma mark -Setters and Getters

-(UUPhotoActionSheet *)sheet{
    if (_sheet == nil) {
        _sheet = [[UUPhotoActionSheet alloc] initWithWeakSuper:self];
        _sheet.delegate = self;
        _sheet.head = YES;
    }
    return _sheet;
}
-(NSArray *)nameArray{
    if (!_nameArray) {
        _nameArray = @[@"我的订单",@"我的服务",@"我的金币",@"我的社区",@"申请达人"];
    }
    return _nameArray;
}

-(NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@"oder_40x40",@"oder_40x40",@"oder_40x40",@"commnuity_40x40",@"oder_40x40"];
    }
    return _imageArray;
}

-(ZZLoginUser *)loginUser{
    if (!_loginUser) {
        _loginUser = [ZZLoginUserTool sharedZZLoginUserTool].loginUser;
    }
    return _loginUser;
}

@end
