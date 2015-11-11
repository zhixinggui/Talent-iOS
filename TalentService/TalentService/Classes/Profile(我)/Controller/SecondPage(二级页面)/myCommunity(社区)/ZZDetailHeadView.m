//
//  ZZDetailHeadView.m
//  TalentService
//
//  Created by charles on 15/11/10.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZDetailHeadView.h"

@interface ZZDetailHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *communityTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *contentDetailView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation ZZDetailHeadView

- (void)awakeFromNib {
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
    CGSize titleLabelSize = [self.titleLabel sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    
    NSString *titleContent = @"阿迪达斯全新Climaheat系列，采用创新锁热结构、湿度管理、隔温系统，提供超强保护，让你无惧寒冷，寒冬热启动。";
    NSMutableAttributedString *attributedString = [titleContent getReplyAttributedStringFont:[UIFont systemFontOfSize:15.0] color:[UIColor darkGrayColor]];
    self.contentLabel.attributedText = attributedString;
    CGSize contentLabelSize = [self.contentLabel sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    
    float allHeight = 0.0;
    for (int i = 0; i<4; i++) {
        UIView *pictureAndDetailView = [[UIView alloc]init];
        pictureAndDetailView.backgroundColor = [UIColor redColor];
        pictureAndDetailView.x = 0;
        pictureAndDetailView.y = allHeight;
        pictureAndDetailView.width = ScreenWidth;
        UIImageView *pictureLv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 200)];
        pictureLv.backgroundColor = [UIColor lightGrayColor];
        [pictureAndDetailView addSubview:pictureLv];
        UILabel *pictureLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(pictureLv.frame)+5, ScreenWidth-20, 100)];
        pictureLabel.numberOfLines = 0;
        NSString *content = @"阿迪达斯全新系列，采用创新锁热结构、湿度管理、隔温系统，提供超强保护，让你无惧寒冷。";
        NSMutableAttributedString *pictureString = [content getReplyAttributedStringFont:[UIFont systemFontOfSize:15.0] color:[UIColor darkGrayColor]];
        pictureLabel.attributedText = pictureString;
        CGSize pictureLabelSize = [pictureLabel  sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
        pictureLabel.height = pictureLabelSize.height;
        
        [pictureAndDetailView addSubview:pictureLabel];
        
        allHeight += CGRectGetMaxY(pictureLabel.frame)+5;
        
        [self.contentDetailView addSubview:pictureAndDetailView];
        
    }
    self.height = 65 + titleLabelSize.height +10 + contentLabelSize.height + 10 + allHeight + 168;
}

@end
