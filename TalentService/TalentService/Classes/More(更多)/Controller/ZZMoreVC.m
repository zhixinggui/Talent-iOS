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
#import "ZZFeedbackVC.h"
#import "ZZMoreExplainVC.h"
#import "ZZSdWebImageTool.h"
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
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super  viewWillAppear:animated];
   
    [self  setCacheButtonTitle];
}

- (void)setCacheButtonTitle{
  
    [self.cacheButton setTitle: [@"缓存"  stringByAppendingString:[ZZSdWebImageTool  sdImageCacheSize]]  forState:UIControlStateNormal];
}
#pragma mark - UITableViewDatasourse

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
    
    switch (indexPath.row) {
        case 0:
        {
            ZZFeedbackVC *feedbackVc = [[ZZFeedbackVC alloc]initWithNib];
            [self.navigationController pushViewController:feedbackVc animated:YES];
        }
            break;
            
        default:
        {
            ZZMoreExplainVC *moreExplainVc = [[ZZMoreExplainVC alloc]initWithNib];
            [self.navigationController pushViewController:moreExplainVc animated:YES];
        }
            break;
    }
    
    
}
- (IBAction)cacheActionButton:(UIButton *)sender {
    [MBProgressHUD  showMessage:@"缓存清理中" toView:self.view];
    [ZZSdWebImageTool  clickClearImageCacheWithBlock:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self  setCacheButtonTitle];
    }];
    
}

@end
