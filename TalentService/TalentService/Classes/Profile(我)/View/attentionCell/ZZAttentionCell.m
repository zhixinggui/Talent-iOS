//
//  ZZAttentionCell.m
//  TalentService
//
//  Created by charles on 15/8/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZAttentionCell.h"
@interface ZZAttentionCell()
@property (weak, nonatomic) IBOutlet UIImageView *headIV;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *identityLabel;

@end
@implementation ZZAttentionCell
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - Setters and Getters
- (void)setOtherUser:(ZZOtherUser *)otherUser {
    
    _otherUser= otherUser;
    self.nameLabel.text = otherUser.userNike;
    ZZUserRole *userRole = otherUser.userRole[0];
    self.identityLabel.text = userRole.eredarName;
    [self.headIV  setHeadImageWithURL:otherUser.userBigImg];
}
@end
