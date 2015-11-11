//
//  ZZTopicSearchVC.m
//  TalentService
//
//  Created by zhizhen on 15/11/10.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicSearchVC.h"
#import "UIBarButtonItem+Extension.h"
#import "ZZMenuButton.h"
#import "MLKMenuPopover.h"
#import "ZZSearchTopicCell.h"
#import "ZZSearchUserCell.h"

#define MENU_POPOVER_FRAME  CGRectMake(20, 64, 130, 90)
@interface ZZTopicSearchVC ()<MLKMenuPopoverDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet ZZMenuButton *selectButton;

@property (nonatomic , strong)MLKMenuPopover *menuPopover;
@property (nonatomic, strong)NSArray *menuItems;
@end

@implementation ZZTopicSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZZViewBackColor;
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.hidesBackButton = YES;
      [self  titleView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.rowHeight = [ZZSearchTopicCell  searchTopicCellheight];
//    [self.tableView  registerNib:[UINib  nibWithNibName:@"ZZSearchTopicCell" bundle:nil] forCellReuseIdentifier:[ZZSearchTopicCell  searchTopicCellIdentifier]];
    self.tableView.rowHeight = [ZZSearchUserCell  searchUserCellheight];
    [self.tableView registerNib:[UINib  nibWithNibName:@"ZZSearchUserCell" bundle:nil] forCellReuseIdentifier:[ZZSearchUserCell  searchUserCellIdentifier]];
}

- (void)titleView{
//    UIButton *cancellButton = [[UIButton  alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [cancellButton  addTarget:self action:@selector(cancell) forControlEvents:UIControlEventTouchUpInside];
//    cancellButton.title = @"取消";
//    UIBarButtonItem *cancellItem = [[UIBarButtonItem alloc]initWithCustomView:cancellButton];
//
//    self.navigationItem.rightBarButtonItems = @[cancellItem,[UIBarButtonItem  seperatorItem]];
    
    
    UIView *searchView = [[[NSBundle  mainBundle]loadNibNamed:@"ZZTitleSearchView" owner:self options:nil]firstObject];
    searchView.width = ScreenWidth- 10;
    searchView.height = 34;

    self.navigationItem.titleView = searchView;
    self.selectButton.title = [self.menuItems firstObject];
    
//    UIButton *selectBuuton = [[UIButton  alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    selectBuuton.title = @"话题";
//    UIBarButtonItem *selectItem = [[UIBarButtonItem alloc]initWithCustomView:selectBuuton];
//   // self.navigationItem.leftBarButtonItem = selectItem;
//   self.navigationItem.leftBarButtonItems = @[[UIBarButtonItem  seperatorItem],selectItem];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ZZSearchTopicCell *cell = [tableView  dequeueReusableCellWithIdentifier:[ZZSearchTopicCell  searchTopicCellIdentifier]];
    ZZSearchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZZSearchUserCell searchUserCellIdentifier]];
    return cell;
}
#pragma mark -MLKMenuPopoverDelegate
-(void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex{
    [self.menuPopover dismissMenuPopover];
    self.selectButton.title = [self.menuItems  objectAtIndex:selectedIndex];
}
#pragma mark -ZZTitleSearchView
- (IBAction)selectedButtonAction:(ZZMenuButton *)sender {
    
    if (self.menuPopover.isShow) {
        [self.menuPopover dismissMenuPopover];
    }else{
        [self.menuPopover showInView:self.navigationController.view];
    }
}
- (IBAction)cancellButtonAction:(UIButton *)sender {
    [self.searchBar  resignFirstResponder];
    [self.navigationController  popViewControllerAnimated:YES];
}

#pragma mark - set or gets
-(MLKMenuPopover *)menuPopover{
    if (_menuPopover == nil) {
        _menuPopover = [[MLKMenuPopover  alloc]initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems];
        _menuPopover.itemImageNames = @[@"mine_close_30x30",@"city_close_30x30"];
        _menuPopover.arrowDirection = MLKMenuPopoverArrowDirectionLeft;
        _menuPopover.menuPopoverDelegate = self;
    }
    return _menuPopover;
}

-(NSArray *)menuItems{
    if (_menuItems  == nil) {
        _menuItems = @[@"用户",@"话题"];
    }
    return _menuItems;
}
@end
