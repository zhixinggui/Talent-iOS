//
//  ZZReplayDetailVC.m
//  TalentService
//
//  Created by charles on 15/11/5.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZReplayDetailVC.h"
#import "ZZReplayCell.h"
@interface ZZReplayDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *replayTV;
@property (weak, nonatomic) IBOutlet UIView *replayView;
@property (strong, nonatomic) IBOutlet UIView *headView;

@end

@implementation ZZReplayDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib* nib = [UINib nibWithNibName:@"ZZReplayCell" bundle:nil];
    [self.replayTV registerNib:nib forCellReuseIdentifier:replayCelldentifier];
    self.replayTV.rowHeight = 81;
    self.replayTV.dataSource = self;
    self.replayTV.delegate = self;
    self.replayTV.tableHeaderView = self.headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      ZZReplayCell *cell = [tableView dequeueReusableCellWithIdentifier:replayCelldentifier forIndexPath:indexPath];
      return cell;
 }


@end
