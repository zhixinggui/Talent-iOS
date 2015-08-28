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
@interface ZZInfoVC ()
@property (strong, nonatomic) IBOutlet UIScrollView *infoScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *infoIV;

@end

@implementation ZZInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoScrollView.backgroundColor = backGroundColor;
//    self.infoScrollView.contentSize = CGSizeMake(0, 400);
}


- (IBAction)gotoMydindan:(UIButton *)sender {
    ZZLog(@"订单订单");
}

/**
 *  活动跳转
 */
- (IBAction)gotoEvent:(UIButton *)sender {
    ZZLog(@"活动活动");
    ZZMyEventVC *myEventVc = [[ZZMyEventVC alloc]initWithNibName:@"ZZMyEventVC" bundle:nil];
    [self.navigationController pushViewController:myEventVc animated:YES];
}

- (IBAction)gotoCommunity:(UIButton *)sender {
    ZZLog(@"社区社区");
    ZZCommunityTVC *communityTvc = [[ZZCommunityTVC alloc]initWithNibName:@"ZZCommunityTVC" bundle:nil];
    [self.navigationController pushViewController:communityTvc animated:YES];
}

- (IBAction)gotoAttentionView:(UIButton *)sender {
    ZZLog(@"关注关注");
}

@end
