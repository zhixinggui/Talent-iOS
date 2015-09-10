//
//  ZZMoreVC.m
//  TalentService
//
//  Created by charles on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMoreVC.h"
#import "ZZMoreCell.h"
#import "ZZMoreName.h"
#import "UIImageView+WebCache.h"
@interface ZZMoreVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *moreTableView;
@property (strong, nonatomic) IBOutlet UIButton *cacheButton;

@end

@implementation ZZMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib* nib = [UINib nibWithNibName:@"ZZMoreCell" bundle:nil];
    [self.moreTableView registerNib:nib forCellReuseIdentifier:moreCelldentifier];
    self.moreTableView.tableFooterView = self.cacheButton;
    self.moreTableView.dataSource = self;
    self.moreTableView.delegate = self;
    /**
     *  缓存按钮
     */
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    NSString *clearCacheName = tmpSize >= 1024 ? [NSString stringWithFormat:@"清除缓存(%.2fM)",tmpSize/1024/1024] : [NSString stringWithFormat:@"清除缓存(%.2fK)",tmpSize/1024];
    [self.cacheButton setTitle:clearCacheName forState:UIControlStateNormal];
}

#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCelldentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = [ZZMoreName getMoreNameArray];
    cell.nameString = nameArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (IBAction)cacheActionButton:(UIButton *)sender {
    ZZLog(@"清除缓存");
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

@end
