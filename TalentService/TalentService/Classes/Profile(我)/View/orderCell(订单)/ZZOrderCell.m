//
//  ZZOrderCell.m
//  TalentService
//
//  Created by charles on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZOrderCell.h"

@interface ZZOrderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@end

@implementation ZZOrderCell

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

#pragma mark - Setters andGetters
- (void)setOrder:(ZZOrder *)order {
    _order = order;
    self.titleLabel.text = order.title;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld",order.price];
    switch (order.status) {
        case 1:
            self.statusLabel.text = @"未支付";
            break;
        case 2:
            self.statusLabel.text = @"已支付";
            break;
        case 3:
            self.statusLabel.text = @"已参加";
            break;
        case 4:
            self.statusLabel.text = @"已过期";
            break;
        case 5:
            self.statusLabel.text = @"已评价";
            break;
        case 6:
            self.statusLabel.text = @"已退款";
            break;
        case 7:
            self.statusLabel.text = @"已取消";
            break;
            
        default:
            break;
    }
    
    if (order.status == 1 && order.status == 7) {
        [self.cancelBT setTitle:@"立即支付"];
    }else if (order.status == 2 && order.status == 4) {
        [self.cancelBT setTitle:@"申请退款"];
    }else if (order.status == 3) {
        [self.cancelBT setTitle:@"立即评价"];
    }else if (order.status == 5) {
        [self.cancelBT setTitle:@"申请退款"];
    }
    
}
@end
