//
//  ZZTopicForumTVC.m
//  TalentService
//
//  Created by zhizhen on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicForumTVC.h"
#import "ZZCommunityCell.h"
@interface ZZTopicForumTVC ()

@end

@implementation ZZTopicForumTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZZViewBackColor;
    [self  setTableViewProperty];
}
- (void)setTableViewProperty{
    UINib* nib = [UINib nibWithNibName:@"ZZCommunityCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:communityCelldentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:communityCelldentifier forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280.0;
}

@end
