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
#import "ZZMyOrderVC.h"
#import "ZZMyselfInfoTVC.h"
#import "ZZInfoDetailVC.h"
#import "ZZInfoModifyVC.h"
@interface ZZInfoVC ()
@property (strong, nonatomic) IBOutlet UIScrollView *infoScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *infoIV;

@end

@implementation ZZInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoScrollView.backgroundColor = backGroundColor;
}


- (IBAction)gotoMydindan:(UIButton *)sender {
    ZZLog(@"订单订单");
    ZZMyOrderVC *orderTvc = [[ZZMyOrderVC alloc]initWithNib];
    [self.navigationController pushViewController:orderTvc animated:YES];
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

@end
