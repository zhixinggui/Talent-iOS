//
//  ZZInfoDetailVC.m
//  TalentService
//
//  Created by charles on 15/9/6.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZInfoDetailVC.h"
#import "ZZCommunityCell.h"
#import "ZZSegmentedControl.h"
#import "ZZCommunityTVC.h"
#import "ZZActivityController.h"
/**
 *  个人页面请求
 */
#import "ZZMyInfoHttpTool.h"
#import "ZZLoginUser.h"
@interface ZZInfoDetailVC ()<UITableViewDataSource,UITableViewDelegate,ZZSegmentedControlDelegate>
@property(nonatomic,strong)ZZLoginUser *loginUser;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *infoDetailTableView;
@property (strong, nonatomic) ZZSegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
@end

@implementation ZZInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人主页";
    UINib* nib = [UINib nibWithNibName:@"ZZCommunityCell" bundle:nil];
    [self.infoDetailTableView registerNib:nib forCellReuseIdentifier:communityCelldentifier];
    self.infoDetailTableView.delegate = self;
    self.infoDetailTableView.dataSource = self;
    self.infoDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.infoDetailTableView.rowHeight = 280;
    self.infoDetailTableView.tableHeaderView = self.headView;
    
    /**
     *  请求
     */
    [ZZMyInfoHttpTool getMyInfoWithUserAttentionId:@(self.userAttentionId) andMyCenter:@(1) success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        ZZLog(@"个人信息infoUser:%@",infoUser);
        self.loginUser = infoUser;
        [self.headIV  setImageWithURL:infoUser.userBigImg];
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:communityCelldentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        [MBProgressHUD  showSuccess:@"关注成功"];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        ZZLog(@"数据返回失败");
        [MBProgressHUD  showError:error];
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
        _segmentControl = [[ZZSegmentedControl alloc]initWithItems:@[@"社区",@"服务"]];
        _segmentControl.delegate = self;
        _segmentControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    }
    return _segmentControl;
}
//-(ZZCommunityTVC *)communityTvc{
//    if (!_communityTvc) {
//        _communityTvc = [[ZZCommunityTVC alloc]init];
//    }
//    return _communityTvc;
//}
//
//-(ZZActivityController *)activityTvc{
//    if (!_activityTvc) {
//        _activityTvc = [[ZZActivityController alloc]init];
//    }
//    return _activityTvc;
//}
@end
