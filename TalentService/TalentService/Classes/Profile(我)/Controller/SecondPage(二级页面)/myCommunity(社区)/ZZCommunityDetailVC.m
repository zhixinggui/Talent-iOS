//
//  ZZCommunityDetailVC.m
//  TalentService
//
//  Created by charles on 15/11/5.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZCommunityDetailVC.h"
#import "ZZPictureAndDetailVIew.h"
#import "ZZTopicDetailCell.h"
#import "ZZTextView.h"
#import "ZZReplayDetailVC.h"
#import "MLKMenuPopover.h"
#define MENU_POPOVER_FRAME  CGRectMake(ScreenWidth-8-140, 64, 140, 132)

@interface ZZCommunityDetailVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,MLKMenuPopoverDelegate>

@property(nonatomic,strong)ZZTextView* repTextField;
@property (weak, nonatomic) IBOutlet UITableView *detailTvc;
@property (weak, nonatomic) IBOutlet UIView *replayView;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *communityTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *contentDetailView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property(nonatomic,strong) MLKMenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;
@end

@implementation ZZCommunityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"话题详情";
    UINib* nib = [UINib nibWithNibName:@"ZZTopicDetailCell" bundle:nil];
    [self.detailTvc registerNib:nib forCellReuseIdentifier:topicCelldentifier];
    self.detailTvc.rowHeight = 350;
    self.detailTvc.delegate = self;
    self.detailTvc.dataSource = self;
    [self.replayView addSubview:self.repTextField];
    [self setNaviRightButtonItems];
    [self communityDetail];
    
    self.menuItems = [NSArray arrayWithObjects:@"分享", @"删除", @"举报", nil];
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
    [self.menuPopover dismissMenuPopover];
    
    self.menuPopover = [[MLKMenuPopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems];
    
    self.menuPopover.menuPopoverDelegate = self;
    [self.menuPopover showInView:self.view];
}

- (void)didClickOnCollection {
    ZZLog(@"收藏");
}

/**
 *话题详情
 */
- (void)communityDetail {
    
    self.communityTypeLabel.layer.cornerRadius = 10;
    self.communityTypeLabel.layer.masksToBounds = YES;
    self.titleLabel.text = @"  阿迪达斯全新Climaheat系列阿迪达斯全新Climaheat系列";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
    textAttachment.image = [UIImage imageNamed:@"top_20x20"];
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    NSTextAttachment *textAttachment1 = [[NSTextAttachment alloc]initWithData:nil ofType:nil];
    textAttachment1.image = [UIImage imageNamed:@"great_20x20"];
    NSAttributedString *textAttachmentString1 = [NSAttributedString attributedStringWithAttachment:textAttachment1];
    [str insertAttributedString:textAttachmentString atIndex:0];
    [str insertAttributedString:textAttachmentString1 atIndex:2];
    self.titleLabel.attributedText = str;
    
    self.contentLabel.text = @"阿迪达斯全新Climaheat系列，采用创新锁热结构、湿度管理、隔温系统，提供超强保护，让你无惧寒冷，寒冬热启动。";
    NSMutableAttributedString *attributedString = [self.contentLabel.text getReplyAttributedStringFont:[UIFont systemFontOfSize:15.0] color:[UIColor darkGrayColor]];
    self.contentLabel.attributedText = attributedString;
    
    int allHeight = 0;
    for (int i = 0; i<4; i++) {
        ZZPictureAndDetailVIew *pictureAndDetailView = [[ZZPictureAndDetailVIew alloc]init];
        pictureAndDetailView = [[[NSBundle  mainBundle]loadNibNamed:@"ZZPictureAndDetailView" owner:self options:nil]firstObject];
        pictureAndDetailView.pictureIVHeight.constant = 200;
        pictureAndDetailView.pictureLabel.text = @"阿迪达斯全新系列，采用创新锁热结构、湿度管理、隔温系统，提供超强保护，让你无惧寒冷。";
//        NSMutableAttributedString *pictureString = [pictureAndDetailView.pictureLabel.text getReplyAttributedStringFont:[UIFont systemFontOfSize:15.0] color:[UIColor darkGrayColor]];
//        pictureAndDetailView.pictureLabel.attributedText = pictureString;
        
        CGSize pictureSize = [pictureAndDetailView.pictureLabel.text textSizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        pictureAndDetailView.pictureLabelHeight.constant = pictureSize.height;
        pictureAndDetailView.frame = CGRectMake(0, allHeight, ScreenWidth, pictureAndDetailView.pictureIVHeight.constant+ 5 + pictureAndDetailView.pictureLabelHeight.constant);
        allHeight += pictureAndDetailView.pictureIVHeight.constant  + 5 + pictureAndDetailView.pictureLabelHeight.constant + 5;
        
        [self.contentDetailView addSubview:pictureAndDetailView];
        self.headView.height = allHeight+360;
    }
    
    self.detailTvc.tableHeaderView = self.headView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


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



#pragma mark -MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex
{
    [self.menuPopover dismissMenuPopover];
    
    NSString *title = [NSString stringWithFormat:@"%@ selected.",[self.menuItems objectAtIndex:selectedIndex]];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
}
@end
