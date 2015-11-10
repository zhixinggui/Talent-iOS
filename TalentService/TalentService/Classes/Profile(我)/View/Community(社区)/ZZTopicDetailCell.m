//
//  ZZTopicDetailCell.m
//  TalentService
//
//  Created by charles on 15/11/4.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicDetailCell.h"

@interface ZZTopicDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *replayNameLabel;

@end


@implementation ZZTopicDetailCell

- (void)awakeFromNib {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.replayNameLabel.text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,6)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(7,24)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(30,5)];
    self.replayNameLabel.attributedText = str;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
