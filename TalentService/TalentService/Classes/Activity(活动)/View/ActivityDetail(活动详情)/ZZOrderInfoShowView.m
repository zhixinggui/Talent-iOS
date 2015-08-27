//
//  ZZOrderInfoShowView.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZOrderInfoShowView.h"

@interface ZZOrderInfoShowView ()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;

@end
@implementation ZZOrderInfoShowView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor  whiteColor];
       //
        UILabel *titleLabel = [[UILabel  alloc]init];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.textColor = ZZLightGrayColor;
        titleLabel.font = ZZContentFont;
        [self  addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *contentLabel = [[UILabel  alloc]init];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.textColor = ZZLightGrayColor;
        contentLabel.font = ZZContentFont;
        contentLabel.numberOfLines = 2;
        contentLabel.adjustsFontSizeToFitWidth = YES;
        [self  addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
}

-(void)layoutSubviews{
    [super  layoutSubviews];
    
    CGFloat titleW = 90;
    CGFloat contentW = self.bounds.size.width - titleW - ZZEdgeMargin;
    CGFloat y = ZZEdgeMargin;
    CGFloat h = self.bounds.size.height - 2 * y;
    self.titleLabel.frame = CGRectMake(0, y, titleW, h);
    self.contentLabel.frame = CGRectMake(titleW, y, contentW, h);
}

-(void)drawRect:(CGRect)rect{
    [ZZSeparGrayColor  set];
    UIRectFill(CGRectMake(0, rect.size.height +2*rect.origin.y - 3, rect.size.width , 1));
}

- (void)setTitle:(NSString *)title content:(NSString *)content{
    self.titleLabel.text = title;
    self.contentLabel.text = content;
}
@end
