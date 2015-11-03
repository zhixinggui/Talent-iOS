//
//  ZZMessageCell.m
//  TalentService
//
//  Created by charles on 15/8/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMessageCell.h"

@interface ZZMessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end


@implementation ZZMessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setServiceMessage:(ZZServiceNotiMessage *)serviceMessage {
    _serviceMessage = serviceMessage;
    self.messageLabel.text = serviceMessage.alert;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
