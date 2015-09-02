//
//  ZZCommunityCell.m
//  TalentService
//
//  Created by charles on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZCommunityCell.h"
@interface ZZCommunityCell()
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstIV;
@property (weak, nonatomic) IBOutlet UIImageView *secondIV;
@property (weak, nonatomic) IBOutlet UIImageView *thirdIV;
@property (weak, nonatomic) IBOutlet UIButton *firstBT;
@property (weak, nonatomic) IBOutlet UIButton *secondBT;
@property (weak, nonatomic) IBOutlet UIButton *thirdBT;

@end
@implementation ZZCommunityCell
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

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [[UIImage imageNamed:@"border_34x34"]drawInRect:CGRectMake(rect.origin.x +5, rect.origin.y+5, rect.size.width - 10, rect.size.height)];

}

#pragma mark - Setters and Getters
- (void)setModel:(ZZCommunityCellModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    
}
@end
