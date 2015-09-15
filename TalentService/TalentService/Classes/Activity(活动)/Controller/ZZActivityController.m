//
//  ZZActivityController.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//
NSString *  const CityStr = @"选择城市";
NSString *  const TypeStr = @"选择类型";
NSString *  const StatusStr = @"选择状态";
#import "ZZActivityController.h"
#import "ZZActivityCell.h"
#import "ZZMenuButton.h"
#import "ZZTopMenuView.h"
#import "ZZActivityDetailController.h"

#import "ZZActivityCity.h"
#import "ZZActivityStatus.h"
#import "ZZActivityType.h"
#import "ZZPopMenu.h"
#import "ZZSelectorView.h"
@interface ZZActivityController ()
/**活动请求到的数组*/
@property (nonatomic, strong)NSMutableArray *activityArray;
/** 城市选择*/
@property (nonatomic, strong)ZZMenuButton *cityMenuBtn;
/**城市选择*/
@property (nonatomic, strong)ZZMenuButton *typeMenuBtn;
/**状态选择  */
@property (nonatomic, strong)ZZMenuButton *statusMenuBtn;
/**顶部选择菜单  */
@property (nonatomic, strong)ZZTopMenuView  *topMenuView;

/**记录选中了那个选择菜单  */
@property (nonatomic, strong)ZZMenuButton *selectMenuBtn;
/**选中的城市  */
@property (nonatomic, strong)ZZActivityCity *selectedCity;
/**选中的状态 */
@property (nonatomic, strong)ZZActivityStatus *selectedStatus;
/**选中的类型  */
@property (nonatomic, strong)ZZActivityType *selectedType;
@end

@implementation ZZActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZZViewBackColor;
    [self  setUpTableView];
}
//设置tableview的相关属性
- (void)setUpTableView{
    self.tableView.rowHeight = [ZZActivityCell  cellHeight];
    //一定要在tableview 分割线设置之前
    [self.tableView  registerNib:[UINib nibWithNibName:@"ZZActivityCell" bundle:nil] forCellReuseIdentifier:[ZZActivityCell   cellXibIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
//设置筛选菜单
- (void)setUpSelectMenu{
    //城市
    ZZMenuButton *city = [[ZZMenuButton  alloc]init];
    [city setTitle:@"城市" forState:UIControlStateNormal];
    [city  addTarget:self action:@selector(cityMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cityMenuBtn = city;
    
    //类型
    ZZMenuButton *type = [[ZZMenuButton alloc]init];
    [type setTitle:@"类型" forState:UIControlStateNormal];
    [type  addTarget:self action:@selector(typeMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.typeMenuBtn = type;
    
    //状态
    ZZMenuButton *status = [[ZZMenuButton alloc]init];
    [status setTitle:@"状态" forState:UIControlStateNormal];
    [status  addTarget:self action:@selector(statusMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.statusMenuBtn = status;
}

#pragma  event response
//城市
- (void)cityMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;
    
    ZZSelectorView *selector = [[ZZSelectorView alloc]init];
    ZZPopMenu *pop = [ZZPopMenu  popMenuWithContentView:selector];
    pop.dimBackground = YES;
//    CGFloat x = CGRectGetMinX(button.frame);
//    CGFloat y = CGRectGetMaxY(button.frame) + 64;
//    CGFloat W = CGRectGetWidth(button.frame);
//    CGFloat h = ScreenHeight - y;
//    [pop  showInRect:CGRectMake(x, y, w, h)];
    [pop showFrom:button];
  
}
//类型
- (void)typeMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;

}
//状态
- (void)statusMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;
    

}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.activityArray.count+5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZActivityCell *cell = [tableView  dequeueReusableCellWithIdentifier:[ZZActivityCell   cellXibIdentifier]  ];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.topMenuView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.topMenuView.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZActivityDetailController *actDetailVC = [[ZZActivityDetailController  alloc]init];
    [self.navigationController  pushViewController:actDetailVC animated:YES];
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -lazy load
-(ZZTopMenuView *)topMenuView{
    if (_topMenuView == nil) {
        //设置tableview的头部
        _topMenuView = [[ZZTopMenuView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        _topMenuView.backgroundColor = [UIColor  whiteColor];
        if (self.cityMenuBtn == nil) {
            [self  setUpSelectMenu];
        }
        _topMenuView.menuButtons = @[self.cityMenuBtn,self.typeMenuBtn,self.statusMenuBtn];
    }
    return _topMenuView;
}



@end
