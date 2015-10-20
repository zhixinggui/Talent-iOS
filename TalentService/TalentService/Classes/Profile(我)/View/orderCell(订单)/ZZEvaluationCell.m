//
//  ZZEvaluationCell.m
//  TalentService
//
//  Created by charles on 15/9/20.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZEvaluationCell.h"

@interface ZZEvaluationCell ()
@property (weak, nonatomic) IBOutlet UIButton *totallyGoodButton;
@property (weak, nonatomic) IBOutlet UIButton *vertGoodButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;
@property (weak, nonatomic) IBOutlet UIButton *sosoButton;
@property (nonatomic, strong)UIButton *selectedButton;
@end

@implementation ZZEvaluationCell
- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)didClickOnEvaluation:(UIButton *)sender {
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
