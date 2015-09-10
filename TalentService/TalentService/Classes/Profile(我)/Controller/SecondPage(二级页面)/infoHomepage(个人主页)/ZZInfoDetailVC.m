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
@interface ZZInfoDetailVC ()<UITableViewDataSource,UITableViewDelegate,ZZSegmentedControlDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *infoDetailTableView;
@property (strong, nonatomic) ZZSegmentedControl *segmentControl;
#warning 暂时用这两个类 到时候替换成个人服务类和社区类
@property (strong, nonatomic) ZZCommunityTVC *communityTvc;
@property (strong, nonatomic) ZZActivityController *activityTvc;
#warning ----------------------------------------------
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
