//
//  ZZDetailRuleView.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZDetailRuleView.h"
#import "ZZUnderLineLabel.h"

@interface ZZDetailRuleView ()<UIActionSheetDelegate>

@end
@implementation ZZDetailRuleView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        [self  setUpChild];
    }
    return self;
}
- (void)setUpChild{
     self.backgroundColor = ZZViewBackColor;
    CGFloat  lineMargin = 10;
    CGFloat   edgeMargin = 20;
   //
    CGFloat underX = 0;
    CGFloat underY = 0;
    CGFloat underW = ScreenWidth;
    CGFloat underH = 44;
    ZZUnderLineLabel *underLabel = [[ZZUnderLineLabel  alloc]initWithFrame:CGRectMake(underX, underY, underW, underH)];
    underLabel.text = @"须知";
    underLabel.textColor = ZZNatiBarColor;
    underLabel.font = ZZContentBoldFont;
    [self addSubview:underLabel];
    
    //头像
    CGFloat headX = edgeMargin;
    CGFloat headY = CGRectGetMaxY(underLabel.frame)+lineMargin;
    CGFloat headW = 50;
    CGFloat headH = headW;
    UIImageView *headIV = [[UIImageView  alloc]initWithFrame:CGRectMake(headX, headY, headW, headH)];
    headIV.contentMode = UIViewContentModeScaleAspectFill;
    headIV.clipsToBounds = YES;
    headIV.layer.cornerRadius = headW * 0.5;
    headIV.layer.borderColor = ZZLightGrayColor.CGColor;
    headIV.layer.borderWidth = 0.5;
    headIV.layer.masksToBounds = YES;
    [self  addSubview:headIV];
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(headIV.frame)+lineMargin;
    CGFloat nameY = headY;
    CGFloat nameW = ScreenWidth - nameX - edgeMargin;
    CGFloat nameH = 20;
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
    nameLabel.text = @"昵称";
    nameLabel.textColor = ZZLightGrayColor;
    nameLabel.font = ZZContentFont;
    [self addSubview:nameLabel];
    
    //身份
    CGFloat permissX = nameX;
    CGFloat permissY = CGRectGetMaxY(nameLabel.frame)+lineMargin;
    CGFloat permissW = nameW/2;
    CGFloat permissH = 20;
    UILabel *permissLabel = [[UILabel alloc]initWithFrame:CGRectMake(permissX, permissY, permissW, permissH)];
    permissLabel.text = @"身份";
    permissLabel.textColor = ZZLightGrayColor;
    permissLabel.font = ZZContentFont;
    [self addSubview:permissLabel];
    
    //内容
    CGFloat contentX = headX + lineMargin;
    CGFloat contentY = MAX(CGRectGetMaxY(headIV.frame), CGRectGetMaxY(permissLabel.frame))+lineMargin;
    CGFloat contentW = ScreenWidth - 2 *contentX;
   
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.attributedText =  [contentLabel  getAttributedStringWithText:@"有道词典是最好用的免费全能翻译软件,\n拥有5亿用户,占据市场第一。 \n独创的“网络释义”功能,轻松收录最新词汇。为您提供准确的在线词典、在线翻译、海量例句、全球..." paragraphSpacing:5 lineSpace:2 stringCharacterSpacing:3 textAlignment:NSTextAlignmentLeft font:ZZContentFont color:ZZLightGrayColor];
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
    [telebutton  setImage:[UIImage  imageNamed:@"T"] forState:UIControlStateNormal];
    telebutton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    [telebutton  setAttributedTitle:[self  getAttributedStringWithText:@"拨打电话" textFont:ZZContentFont textColor:ZZLightGrayColor content:@"15821565760" contentFont:ZZContentFont contentColor:ZZGreenColor] forState:UIControlStateNormal];
      [telebutton  setTitleColor:ZZGreenColor forState:UIControlStateNormal];
    telebutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [telebutton  addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:telebutton];
    
    self.totalHeight = CGRectGetMaxY(telebutton.frame);
    
}
#pragma mark event response
- (void)callPhone{
  
        UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"确定拨打这个号码",nil];
        
        [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //拨打电话
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://15821565760"]];
    }
}
//画线
-(void)drawRect:(CGRect)rect{
    [super  drawRect:rect];
    
    [ZZSeparGrayColor  set];
    UIRectFill(CGRectMake(0, 0, rect.size.width, 2));
}
@end
