//
//  ZZMoreTalentController.m
//  TalentService
//
//  Created by zhizhen on 15/9/21.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZMoreTalentController.h"
#import "ZZStarTableViewCell.h"
#import "ZZBaseUser.h"
#import "ZZInfoDetailVC.h"
@interface ZZMoreTalentController ()<ZZStarTableViewCellDelegate>

@end

@implementation ZZMoreTalentController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"更多达人";
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.rowHeight = [ZZStarTableViewCell  starCellHeight];
}



#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.talents.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZStarTableViewCell *cell = [ZZStarTableViewCell  starTableViewCellWithTableView:tableView delegate:self];
    cell.baseUser = self.talents[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
#pragma mark - ZZStarTableViewCellDelegate
-(void)starCellHeadImageTap:(ZZStarTableViewCell *)starTableViewCell{
    NSIndexPath *indexpath = [self.tableView  indexPathForCell:starTableViewCell];
    ZZInfoDetailVC *infoDvc = [[ZZInfoDetailVC alloc]init];
    ZZBaseUser *baseUser = self.talents[indexpath.row];
    infoDvc.userAttentionId = baseUser.userId;
    [self.navigationController pushViewController:infoDvc animated:YES ];
}
@end
