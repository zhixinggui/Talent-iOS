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
/**
 *  我的页面请求
 */
#import "ZZMyInfoHttpTool.h"

@interface ZZInfoVC ()<UITableViewDataSource,UITableViewDelegate,UUPhotoActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *tableHeadView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@property (strong, nonatomic) IBOutlet UIImageView *infoIV;
/** 选择图片*/
@property (nonatomic, strong) UUPhotoActionSheet *sheet;
@property (nonatomic,strong)NSArray *nameArray;
@property (nonatomic,strong)NSArray *imageArray;
@end

@implementation ZZInfoVC

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
    /**
     *  请求
     */
    [ZZMyInfoHttpTool getMyInfoWithUserAttentionId:nil andMyCenter:nil success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        ZZLog(@"个人信息:%@",infoUser);
    } failure:^(NSString *error, ZZNetDataType datatype) {
        ZZLog(@"请求失败");
    }];
    
}

/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

-(void)messageAction:(UIButton*)sender{
    ZZLog(@"消息消息");
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
                ZZJoinOrderTVC *jionOrderTvc = [[ZZJoinOrderTVC alloc]initWithNib];
                [self.navigationController pushViewController:jionOrderTvc animated:YES];
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
- (IBAction)gotoInformation:(UIButton *)sender {
    ZZLog(@"个人信息");
    ZZInfoModifyVC *myselfInfoTvc = [[ZZInfoModifyVC alloc]initWithNib];
    [self.navigationController pushViewController:myselfInfoTvc animated:YES];
}
- (IBAction)gotoInfoDetail:(UIButton *)sender {
    ZZLog(@"个人详细资料");
    ZZInfoDetailVC *infoDetailVc = [[ZZInfoDetailVC alloc]initWithNib];
    [self.navigationController pushViewController:infoDetailVc animated:YES];
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
- (IBAction)gotoMessage:(UIButton *)sender {
    ZZLog(@"消息消息");
    ZZMessageTVC *messageTvc = [[ZZMessageTVC alloc]initWithNib];
    [self.navigationController pushViewController:messageTvc animated:YES];
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
        _nameArray = @[@"我的订单",@"我的接单",@"我的金币",@"我的社区",@"申请达人"];
    }
    return _nameArray;
}

-(NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@"oder_40x40",@"oder_40x40",@"oder_40x40",@"commnuity_40x40",@"oder_40x40"];
    }
    return _imageArray;
}

@end
