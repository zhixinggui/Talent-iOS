//
//  ZZHomeViewController.m
//  TalentService
//
//  Created by zhizhen on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZHomeViewController.h"
#import "ZZActivityCell.h"
#import "ZZHeadView.h"
#import "ZZTableHeadView.h"
#import "ZZActivityDetailController.h"
#import "ZZApplyVC.h"
@interface ZZHomeViewController ()
@property (nonatomic, strong)ZZHeadView *headView;
@property (nonatomic, strong)NSMutableArray *activityArray;
@end

@implementation ZZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZZViewBackColor;
   //设置tableview的相关属性
    [self setUpTableView];
    [self  setUpRightBarItem];

}
//设置tableview的相关属性
- (void)setUpTableView{
    ZZTableHeadView *view = [[ZZTableHeadView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/2)];
    self.tableView.tableHeaderView = view;
    self.tableView.rowHeight = [ZZActivityCell  cellHeight];
    //一定要在tableview 分割线设置之前
     [self.tableView  registerNib:[UINib nibWithNibName:@"ZZActivityCell" bundle:nil] forCellReuseIdentifier:[ZZActivityCell  cellXibIdentifier]];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}
- (void)setUpRightBarItem{
   
    UIBarButtonItem *barItem = [[UIBarButtonItem  alloc]initWithTitle:@"申请达人" style:UIBarButtonItemStyleDone target:self action:@selector(applySuper)];
    self.navigationItem.rightBarButtonItem = barItem;
}


#pragma mark - event response
- (void)applySuper{
    pushVC(ZZApplyVC);
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.activityArray.count+10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZActivityCell *cell = [tableView  dequeueReusableCellWithIdentifier:[ZZActivityCell  cellXibIdentifier] ];
    ZZLog(@"%@",cell);
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.headView.height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  return   self.headView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZActivityDetailController *actDetailVC = [[ZZActivityDetailController  alloc]init];
    [self.navigationController  pushViewController:actDetailVC animated:YES];
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -lazy load
-(NSMutableArray *)activityArray{
    if (_activityArray == nil) {
        _activityArray = [NSMutableArray  array];
    }
    return _activityArray;
}

-(ZZHeadView *)headView{
    if (_headView == nil) {
        _headView = [[[NSBundle  mainBundle]loadNibNamed:@"ZZHeadView" owner:self options:nil] lastObject];
    }
    return _headView;
}

@end
