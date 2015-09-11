//
//  ZZAttentionVC.m
//  TalentService
//
//  Created by charles on 15/8/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZAttentionVC.h"
#import "ZZSegmentedControl.h"
#import "ZZAttentionCell.h"
@interface ZZAttentionVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *attentionTV;
@property(nonatomic,strong)ZZSegmentedControl *attentionSegmentedControl;
@end

@implementation ZZAttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    self.attentionTV.delegate = self;
    self.attentionTV.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"ZZAttentionCell" bundle:nil];
    [self.attentionTV registerNib:nib forCellReuseIdentifier:attentionCelldentifier];
    self.attentionTV.rowHeight = 100;
    self.attentionTV.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - UITableViewDatasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZAttentionCell *cell = [tableView  dequeueReusableCellWithIdentifier:attentionCelldentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.attentionSegmentedControl;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark setter andGetter
-(ZZSegmentedControl *)attentionSegmentedControl{
    if (!_attentionSegmentedControl) {
        _attentionSegmentedControl = [[ZZSegmentedControl alloc]initWithItems:@[@"朋友",@"达人"]];
        _attentionSegmentedControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    }
    return _attentionSegmentedControl;
}

@end
