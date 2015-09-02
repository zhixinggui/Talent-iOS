//
//  ZZMyEventVC.m
//  TalentService
//
//  Created by charles on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMyEventVC.h"
#import "ZZActivityCell.h"
#import "ZZSegmentedControl.h"
@interface ZZMyEventVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *eventTableView;
@property(nonatomic,strong)ZZSegmentedControl *mySegmentControl;
@end

@implementation ZZMyEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动";
    [self.eventTableView  registerNib:[UINib nibWithNibName:@"ZZActivityCell" bundle:nil] forCellReuseIdentifier:@"ActivityCell"];
    self.eventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.eventTableView.rowHeight = [ZZActivityCell cellHeight];
    self.eventTableView.delegate = self;
    self.eventTableView.dataSource = self;
}

#pragma mark - UITableViewDatasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZActivityCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"ActivityCell"  ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.mySegmentControl;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(ZZSegmentedControl *)mySegmentControl{
    if (!_mySegmentControl) {
        _mySegmentControl = [[ZZSegmentedControl alloc]initWithItems:@[@"活动",@"收藏"]];
        _mySegmentControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    }
    return _mySegmentControl;
}

@end
