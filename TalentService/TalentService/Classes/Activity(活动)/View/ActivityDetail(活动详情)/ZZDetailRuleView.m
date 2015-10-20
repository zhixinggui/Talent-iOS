//
//  ZZDetailRuleView.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZDetailRuleView.h"

#import "ZZHeadImageView.h"
#import "ZZStarTableViewCell.h"
#import "ZZActivity.h"
#import "ZZInfoDetailVC.h"
#import "ZZActivityDetailController.h"
#import "ZZBaseUser.h"
#import "ZZMoreTalentController.h"
@interface ZZDetailRuleView ()<UIActionSheetDelegate,ZZStarTableViewCellDelegate>

@end
@implementation ZZDetailRuleView

-(void)setActivity:(ZZActivity *)activity{
    _activity  = activity;
    [self  setUpChild];
}
- (void)setUpChild{
     self.backgroundColor = [UIColor whiteColor];
    CGFloat  lineMargin = 10;
    CGFloat   edgeMargin = 20;
   //
    CGFloat underX = 20;
    CGFloat underY = 0;
    CGFloat underW = ScreenWidth-2*underX;

    NSString* title = [@"     "  stringByAppendingString:self.activity.title];
    CGSize size = [title  sizeWithFont:ZZContentBoldFont maxW:underW];
     CGFloat underH = size.height+20;
    UILabel *underLabel = [[UILabel  alloc]initWithFrame:CGRectMake(underX, underY, underW, underH)];
    underLabel.numberOfLines = 0;
    underLabel.text = self.activity.title;
    underLabel.textColor = ZZNatiBarColor;
    underLabel.font = ZZContentBoldFont;
    [self addSubview:underLabel];
    
    CGFloat separLineX = underX/2;
    CGFloat separLineY = CGRectGetMaxY(underLabel.frame);
    CGFloat separLineW = ScreenWidth-2*separLineX;
    CGFloat separLineH = 1;
    UIView* separLine = [[UIView alloc]initWithFrame:CGRectMake(separLineX, separLineY, separLineW, separLineH)];
    separLine.backgroundColor = ZZSeparGrayColor;
    [self  addSubview:separLine];
  
   CGFloat headY = CGRectGetMaxY(separLine.frame)+lineMargin;
    ZZStarTableViewCell *starView = [ZZStarTableViewCell starCellViewWithDelegate:self];
    starView.baseUser = [self.activity.userInfoList firstObject];
    starView.frame = CGRectMake(0, headY, ScreenWidth, [ZZStarTableViewCell starCellHeight]);
  
    [self addSubview:starView];
    
    if (self.activity.userInfoList.count>1) {
        CGFloat moreW = 40;
        CGFloat moreH = moreW;
        CGFloat moreX = CGRectGetWidth(starView.frame)-moreW;
        CGFloat moreY = (CGRectGetHeight(starView.frame)-moreH)/2;
        UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(moreX, moreY, moreW, moreH)];
 
        [moreButton  setImage:[UIImage  imageNamed:@"right_20x20"] forState:UIControlStateNormal];
        [moreButton  addTarget:self action:@selector(moreTalentVC) forControlEvents:UIControlEventTouchUpInside];
        [starView  addSubview:moreButton];
    }
  
//
    //内容
    CGFloat contentX =  lineMargin;
    CGFloat contentY = CGRectGetMaxY(starView.frame)+lineMargin;
    CGFloat contentW = ScreenWidth - 2 *contentX;
   
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.attributedText =  [contentLabel  getAttributedStringWithText:self.activity.detailRule paragraphSpacing:ZZParagraphSpace lineSpace:ZZLineSpace stringCharacterSpacing:ZZCharSpace textAlignment:NSTextAlignmentLeft font:ZZContentFont color:ZZLightGrayColor];
    CGSize contentSize = [contentLabel sizeThatFits:CGSizeMake(contentW, MAXFLOAT)];
    contentLabel.frame = (CGRect){{contentX,contentY},contentSize};
    [self addSubview:contentLabel];
    
    //
    CGFloat teleX = 0;
    CGFloat teleY = CGRectGetMaxY(contentLabel.frame)+lineMargin;
    CGFloat teleW = ScreenWidth - 2*teleX;
    CGFloat teleH = 40;
    UIButton *telebutton = [[UIButton alloc]initWithFrame:CGRectMake(teleX, teleY, teleW, teleH)];
    telebutton.contentEdgeInsets = UIEdgeInsetsMake(0, edgeMargin, 0, edgeMargin);
    telebutton.backgroundColor = [UIColor  whiteColor];
    [telebutton  setImage:[UIImage  imageNamed:@"phone_30x30"] forState:UIControlStateNormal];
    telebutton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    [telebutton  setAttributedTitle:[self  getAttributedStringWithText:@"咨询电话" textFont:ZZContentFont textColor:ZZLightGrayColor content:self.activity.servicePhone  contentFont:ZZContentFont contentColor:ZZGreenColor] forState:UIControlStateNormal];
      [telebutton  setTitleColor:ZZGreenColor forState:UIControlStateNormal];
    telebutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [telebutton  addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:telebutton];
    
    self.totalHeight = CGRectGetMaxY(telebutton.frame);
    
}
#pragma mark event response
//显示所有主办达人
- (void)moreTalentVC{
    ZZMoreTalentController *moreVC = [[ZZMoreTalentController alloc]init];
    moreVC.talents = self.activity.userInfoList;
    [self.delegateVC.navigationController  pushViewController:moreVC animated:YES];
}
- (void)callPhone{
  
        UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"确定拨打这个号码",nil];
        
        [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}
#pragma mark - ZZStarTableViewCellDelegate
-(void)starCellHeadImageTap:(ZZStarTableViewCell *)starTableViewCell{
    ZZInfoDetailVC *infoDvc = [[ZZInfoDetailVC alloc]init];
    ZZBaseUser *baseUser = [self.activity.userInfoList firstObject];
    infoDvc.userAttentionId = baseUser.userId;
    [self.delegateVC.navigationController pushViewController:infoDvc animated:YES ];
}
#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //拨打电话 @"tel://15821565760"
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"tel://%@",self.activity.servicePhone]]];
    }
}
//画线
-(void)drawRect:(CGRect)rect{
    [super  drawRect:rect];
    
    [ZZSeparGrayColor  set];
    UIRectFill(CGRectMake(0, 0, rect.size.width, 2));
}
@end
