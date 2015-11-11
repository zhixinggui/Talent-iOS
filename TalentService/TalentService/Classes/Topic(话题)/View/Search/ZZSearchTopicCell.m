//
//  ZZSearchUserCell.m
//  TalentService
//
//  Created by zhizhen on 15/11/11.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZSearchTopicCell.h"
#import "ZZHeadImageView.h"
@interface ZZSearchTopicCell ()
@property (weak, nonatomic) IBOutlet ZZHeadImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tanentTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *seeButton;

@end

@implementation ZZSearchTopicCell

-(void)awakeFromNib{
    self.topicTypeLabel.backgroundColor = ZZNatiBarColor;
    self.userNameLabel.textColor = ZZDarkGrayColor;
    self.tanentTypeLabel.textColor = ZZLightGrayColor;
    self.titleLabel.textColor = ZZDarkGrayColor;
    self.contentLabel.textColor = ZZLightGrayColor;
}
+ (NSString *)searchTopicCellIdentifier{
    return @"ZZSearchTopicCell";
}
+ (CGFloat)searchTopicCellheight{
    return 162.0;
}

@end
