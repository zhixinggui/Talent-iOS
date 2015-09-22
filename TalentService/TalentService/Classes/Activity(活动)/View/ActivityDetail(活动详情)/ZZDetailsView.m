//
//  ZZDetailsView.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZDetailsView.h"
#import "ZZUnderLineLabel.h"
@implementation ZZDetailsView


-(void)setActivity:(ZZActivity *)activity{
    _activity = activity;
    [self setUpChild];
}
- (void)setUpChild{
     self.backgroundColor = [UIColor  whiteColor];
    CGFloat  lineMargin = 10;
    CGFloat   edgeMargin = 20;
    //
    CGFloat underX = 0;
    CGFloat underY = 0;
    CGFloat underW = ScreenWidth;
    CGFloat underH = 44;
    ZZUnderLineLabel *underLabel = [[ZZUnderLineLabel  alloc]initWithFrame:CGRectMake(underX, underY, underW, underH)];
    underLabel.text = @"详情";
    underLabel.textColor = ZZNatiBarColor;
    underLabel.font = ZZContentBoldFont;
    [self addSubview:underLabel];
    //
    CGFloat ivX = edgeMargin;
    CGFloat ivY = CGRectGetMaxY(underLabel.frame)+lineMargin;
    CGFloat ivW = ScreenWidth - 2*ivX;
    CGFloat ivH = ivW;
    UIImageView *imageView = [[UIImageView  alloc ]initWithFrame:CGRectMake(ivX, ivY, ivW, ivH)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = [UIColor  orangeColor];
    [self  addSubview:imageView];
    
    //内容
    CGFloat descX = ivX;
    CGFloat descY = CGRectGetMaxY(imageView.frame)+lineMargin;
    CGFloat descW = ivW;

    UILabel *descLabel = [[UILabel  alloc]init];
    descLabel.numberOfLines = 0;
    descLabel.attributedText =  [descLabel  getAttributedStringWithText:@"有道词典是最好用的免费全能翻译软件,拥有5亿用户,占据市场第一。 独创的“网络释义”功能,轻松收录最新词汇。为您提供准确的在线词典、在线翻译、海量例句、全球..." paragraphSpacing:5 lineSpace:2 stringCharacterSpacing:3 textAlignment:NSTextAlignmentLeft font:ZZContentFont color:ZZLightGrayColor];
    CGSize descSize = [descLabel sizeThatFits:CGSizeMake(descW, MAXFLOAT)];
    descLabel.frame = (CGRect){{descX,descY},descSize};
    [self addSubview:descLabel];
    
    self.totalHeight = CGRectGetMaxY(descLabel.frame)+lineMargin;
}

//画线
-(void)drawRect:(CGRect)rect{
    [super  drawRect:rect];
    [ZZLightGrayColor  set];
    UIRectFill(CGRectMake(0, 0, rect.size.width, 2));
}
@end
