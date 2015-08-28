//
//  ZZActivityController.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityController.h"
#import "ZZActivityCell.h"
#import "ZZMenuButton.h"
#import "ZZTopMenuView.h"
#import "ZZActivityDetailController.h"
#import "ZZPopMenu.h"
@interface ZZActivityController ()<ZZPopMenuDelegate>
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
    
    CGFloat menuW = 200;
    CGFloat menuH = 300;
    CGFloat menuX = 40;
    CGFloat menuY =CGRectGetMaxY(button.frame)+64;
    
    ZZPopMenu *menu = [[ZZPopMenu alloc ] initWithContentView:nil];
        menu.dimBackground = YES;
    menu.delegate = self;
    menu.arrowPosition = ZZTopMenuArrowPositionLeft;
    [menu showInRect:CGRectMake(menuX, menuY, menuW, menuH)];
}
//类型
- (void)typeMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;
    
    CGFloat menuW = 200;
    CGFloat menuH = 300;
    CGFloat menuX = CGRectGetMidX(button.frame)- menuW/2;
    CGFloat menuY =CGRectGetMaxY(button.frame)+64;
    
    ZZPopMenu *menu = [[ZZPopMenu alloc ] initWithContentView:nil];
    menu.arrowPosition = ZZTopMenuArrowPositionCenter;
        menu.dimBackground = YES;
     menu.delegate = self;
    [menu showInRect:CGRectMake(menuX, menuY, menuW, menuH)];
}
//状态
- (void)statusMenuBtnClick:(ZZMenuButton *)button{
    self.selectMenuBtn.selected = NO;
    button.selected = YES;
    self.selectMenuBtn = button;

    CGFloat menuW = 200;
    CGFloat menuH = 300;
    CGFloat menuX = ScreenWidth - menuW - 40;
    CGFloat menuY =CGRectGetMaxY(button.frame)+64;
    
    ZZPopMenu *menu = [[ZZPopMenu alloc ] initWithContentView:nil];
    menu.arrowPosition = ZZTopMenuArrowPositionRight;
       menu.dimBackground = YES;
     menu.delegate = self;
    [menu showInRect:CGRectMake(menuX, menuY, menuW, menuH)];
}

#pragma mark - ZZPopMenuDelegate

-(void)popMenuDidDismissed:(ZZPopMenu *)popMenu{
    self.selectMenuBtn.selected = NO;
    self.selectMenuBtn = nil;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
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
        _topMenuView.backgroundColor = [UIColor  clearColor];
        if (self.cityMenuBtn == nil) {
            [self  setUpSelectMenu];
        }
        _topMenuView.menuButtons = @[self.cityMenuBtn,self.typeMenuBtn,self.statusMenuBtn];
    }
    return _topMenuView;
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
