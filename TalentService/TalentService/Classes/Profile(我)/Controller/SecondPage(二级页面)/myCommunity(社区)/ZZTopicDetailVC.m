//
//  ZZTopicDetailVC.m
//  TalentService
//
//  Created by charles on 15/11/10.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicDetailVC.h"
#import "ZZDetailHeadView.h"
#import "ZZTopicReplayView.h"
#import "ZZTopicDetailCell.h"
#import "ZZReplayDetailVC.h"
#import "ZZIQKeyBoardTool.h"
#import "MLKMenuPopover.h"

#define MENU_POPOVER_FRAME  CGRectMake(ScreenWidth-8-130, 64, 130, 132)
@interface ZZTopicDetailVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,MLKMenuPopoverDelegate>
@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (weak, nonatomic) IBOutlet UISlider *pageSlider;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (weak, nonatomic) IBOutlet UITableView *detailTvc;
@property (weak, nonatomic) IBOutlet UIView *replayView;
@property (strong, nonatomic) ZZDetailHeadView *detailHeadView;
@property (strong, nonatomic) ZZTopicReplayView *topicReplayView;
@property (nonatomic) BOOL isClicked;

@property(nonatomic,strong) MLKMenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;
@end

@implementation ZZTopicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ZZKeyBoardTool(close);
    ZZLog(@"时间时间: %@",[NSDate date]);
    self.title = @"话题详情";
    UINib* nib = [UINib nibWithNibName:@"ZZTopicDetailCell" bundle:nil];
    [self.detailTvc registerNib:nib forCellReuseIdentifier:topicCelldentifier];
    self.detailTvc.rowHeight = 350;
    self.detailTvc.delegate = self;
    self.detailTvc.dataSource = self;
    [self setNaviRightButtonItems];
    self.detailTvc.tableHeaderView = self.detailHeadView;
    self.pageView.hidden = YES;
    self.pageSlider.minimumValue = 0;  //设置滑轮所能滚动到的最小值
    self.pageSlider.maximumValue = 10;  //设置滑轮所能滚动到的最大值
    [self.pageSlider addTarget:self action:@selector(change) forControlEvents:UIControlEventValueChanged];
    //为slider添加方法当slider的值改变时就会触发change方法
    
    self.pageSlider.continuous = YES;
    //默认值为YES设置为YES只要滑轮滚动就会触发change方法设置为NO只有当滑轮停止移动时才会触发change方法
    
    self.menuItems = [NSArray arrayWithObjects:@"分享", @"删除", @"举报", nil];
}

- (void)change {
    self.pageLabel.text = [NSString stringWithFormat:@"第%ld/%ld页",(long)self.pageSlider.value,(long)self.pageSlider.maximumValue];
}

/**
 *navigation右边的button
 */
- (void)setNaviRightButtonItems {
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10;
    
    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [moreButton addTarget:self action:@selector(didClickOnMoreaction) forControlEvents:UIControlEventTouchUpInside];
    [moreButton setImage:@"more_close_30x30"];
    UIButton *collectButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [collectButton addTarget:self action:@selector(didClickOnCollection) forControlEvents:UIControlEventTouchUpInside];
    [collectButton setImage:@"collect_40x40"];
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc]initWithCustomView:moreButton];
    
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc]initWithCustomView:collectButton];
    
    self.navigationItem.rightBarButtonItems = @[negativeSeperator,right1,right2];
    
}

- (void)didClickOnMoreaction {
    ZZLog(@"更多");
    if (self.menuPopover.isShow) {
        [self.menuPopover dismissMenuPopover];
    }else{
         [self.menuPopover showInView:self.navigationController.view];
    }
    
//    
//    self.menuPopover = [[MLKMenuPopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems];
//    
//    self.menuPopover.menuPopoverDelegate = self;
   
}

- (void)didClickOnCollection {
    ZZLog(@"收藏");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTopicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCelldentifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZReplayDetailVC *replayDetailVc = [[ZZReplayDetailVC alloc]initWithNib];
    [self.navigationController pushViewController:replayDetailVc animated:YES];
}

#pragma mark -DidClickOnReplay
- (IBAction)didClickOnReplay:(UIButton *)sender {
   
    [self.navigationController.view addSubview:self.topicReplayView];
    [self.topicReplayView.replayTextView becomeFirstResponder];
}

- (IBAction)didClickOnPage:(UIButton *)sender {
    
    if (!self.isClicked) {
        self.pageView.hidden = NO;
        self.isClicked = !self.isClicked;
    }else {
        self.pageView.hidden = YES;
        self.isClicked = !self.isClicked;
    }
}

#pragma mark -TextViewDelegete
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.topicReplayView removeFromSuperview];
}

#pragma mark -MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex
{
    [self.menuPopover dismissMenuPopover];
    
    NSString *title = [NSString stringWithFormat:@"%@ selected.",[self.menuItems objectAtIndex:selectedIndex]];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    
    [alertView show];
    [alertView  dismissAfter:1];
}
#pragma mark -Getters and Setters
- (ZZDetailHeadView *)detailHeadView {
    if (_detailHeadView == nil) {
        _detailHeadView = [[[NSBundle  mainBundle]loadNibNamed:@"ZZDetailHeadView" owner:nil options:nil]firstObject];
    }
    return  _detailHeadView;
}

- (ZZTopicReplayView *)topicReplayView {
    if (_topicReplayView == nil) {
        _topicReplayView = [[[NSBundle  mainBundle]loadNibNamed:@"ZZTopicReplayView" owner:nil options:nil]firstObject];
        _topicReplayView.replayTextView.delegate = self;
    }
    return  _topicReplayView;
}

-(MLKMenuPopover *)menuPopover{
    if (_menuPopover == nil) {
        _menuPopover = [[MLKMenuPopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems];
        _menuPopover.itemImageNames = @[@""];
        _menuPopover.menuPopoverDelegate = self;
    }
    return _menuPopover;
}
- (void)dealloc {
    ZZKeyBoardTool(open);
}
@end
