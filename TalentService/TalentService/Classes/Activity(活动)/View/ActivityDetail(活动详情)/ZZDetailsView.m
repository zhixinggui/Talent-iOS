//
//  ZZDetailsView.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZDetailsView.h"

#import "ZZActivity.h"
#import "ZZImageContent.h"
#import "ZZActivityDetailController.h"
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
    CGFloat underX = 20;
    CGFloat underY = 0;
    CGFloat underW = ScreenWidth - 2*underX;
    CGFloat underH = 44;
    UILabel *underLabel = [[UILabel  alloc]initWithFrame:CGRectMake(underX, underY, underW, underH)];
    underLabel.text = @"详情";
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
    
    self.totalHeight = CGRectGetMaxY(separLine.frame)+lineMargin;
    
  
    //内容
    CGFloat conX = edgeMargin;
    CGFloat conY = self.totalHeight;
    CGFloat conW = ScreenWidth - 2*conX;

    UILabel *conLabel = [[UILabel  alloc]init];
    conLabel.font = ZZContentFont;
    conLabel.textColor = ZZLightGrayColor;
    [conLabel  setDefineText:self.activity.content];
    CGSize conSize = [conLabel sizeThatFits:CGSizeMake(conW, MAXFLOAT)];
    conLabel.frame = (CGRect){{conX,conY},conSize};
    [self addSubview:conLabel];
    
    self.totalHeight = CGRectGetMaxY(conLabel.frame)+lineMargin;
    
    for (NSInteger i = 0; i<self.activity.serviceImgList.count; i++) {
    
        ZZImageContent *imageContent = self.activity.serviceImgList[i];
        
            CGFloat ivX = edgeMargin;
            CGFloat ivY = self.totalHeight+lineMargin;
            CGFloat ivW = ScreenWidth - 2*ivX;
            CGFloat ivH = ivW * imageContent.imgHeight /imageContent.imgWidth;
            UIImageView *imageView = [[UIImageView  alloc ]initWithFrame:CGRectMake(ivX, ivY, ivW, ivH)];
            imageView.tag = i;
        imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
        [imageView setPictureImageWithURL:imageContent.imgPath];
            [imageView  addTarget:self action:@selector(showBigImage:)];
            [self  addSubview:imageView];
            
            //内容
            CGFloat descX = ivX;
            CGFloat descY = CGRectGetMaxY(imageView.frame)+lineMargin;
            CGFloat descW = ivW;
            
            UILabel *descLabel = [[UILabel  alloc]init];
        descLabel.font = ZZContentFont;
        descLabel.textColor = ZZLightGrayColor;
        [descLabel  setDefineText:imageContent.content];
            CGSize descSize = [descLabel sizeThatFits:CGSizeMake(descW, MAXFLOAT)];
            descLabel.frame = (CGRect){{descX,descY},descSize};
            [self addSubview:descLabel];
            
            self.totalHeight = CGRectGetMaxY(descLabel.frame)+lineMargin;
     
    }
    //
   
}

//画线
-(void)drawRect:(CGRect)rect{
    [super  drawRect:rect];
    [ZZLightGrayColor  set];
    UIRectFill(CGRectMake(0, 0, rect.size.width, 2));
}

-(void)showBigImage:(UITapGestureRecognizer *)tap{
      [self.delegateVC  showBigImage:YES currentpage:tap.view.tag];
}
@end
