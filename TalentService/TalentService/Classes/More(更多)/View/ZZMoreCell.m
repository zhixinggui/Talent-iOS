//
//  ZZMoreCell.m
//  TalentService
//
//  Created by charles on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMoreCell.h"
#import "UIImageView+WebCache.h"
@interface ZZMoreCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZZMoreCell

- (void)awakeFromNib {
    // Initialization code
}
#pragma mark - Getters and Setters

//Setters
-(void)setNameString:(NSString *)nameString{
    self.titleLabel.text = nameString;
}

//Getters
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
