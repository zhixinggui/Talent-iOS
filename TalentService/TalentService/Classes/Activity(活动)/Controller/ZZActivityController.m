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
#import "ZZActivityClassSelector.h"

#import "ZZActivityCity.h"
#import "ZZActivityStatus.h"
#import "ZZActivityType.h"
@interface ZZActivityController ()<ZZActivityClassSelectorDelegate>
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

@property (nonatomic, strong)ZZActivityClassSelector *classSelector;

@property (nonatomic, strong)ZZActivityCity *selectedCity;

@property (nonatomic, strong)ZZActivityStatus *selectedStatus;

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
    
    self.classSelector.title = CityStr;
    [self.classSelector  showAnimation];
    
    
}
//类型
- (void)typeMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;
    
    self.classSelector.title = TypeStr;
    [self.classSelector  showAnimation];
    
   
}
//状态
- (void)statusMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;
    
    self.classSelector.title = StatusStr;
    [self.classSelector  showAnimation];
  
}
#pragma mark - ZZActivityClassSelectorDelegate
-(void)activityClassSelector:(ZZActivityClassSelector *)activityClassSelector selectNsobject:(id <ZZActivityClassSelectorShowDele>)object title:(NSString *)title{
    if ([title isEqualToString:CityStr]) {
        self.selectedCity = (ZZActivityCity *)  object;
    }else if ([title isEqualToString:TypeStr]){
        self.selectedType = (ZZActivityType *)object;
    }else if ([title  isEqualToString:StatusStr]){
        self.selectedStatus = (ZZActivityStatus *)object;
    }
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

-(ZZActivityClassSelector *)classSelector{
    if (_classSelector == nil) {
        _classSelector = [ZZActivityClassSelector  activityClassSelectorWithDlegate:self];
    }
    return _classSelector;
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
