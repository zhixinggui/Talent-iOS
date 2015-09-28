//
//  ZZOrderCell.m
//  TalentService
//
//  Created by charles on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZOrderCell.h"

@interface ZZOrderCell ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBT;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
//@property (nonatomic)ZZOrderStatus orderStatus;

@end

@implementation ZZOrderCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    self.headIV.contentMode = UIViewContentModeScaleAspectFill;
    self.headIV.clipsToBounds = YES;
}

#pragma mark - Setters andGetters
- (void)setOrder:(ZZOrder *)order {
    self.cancelBT.hidden = NO;
    _order = order;
    self.titleLabel.text = order.title;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",order.price];
    switch (order.status) {
        case ZZOrderStatusNotPaid:
            self.statusLabel.text = @"未支付";

            break;
        case ZZOrderStatusPaid:
            self.statusLabel.text = @"已支付";

            break;
        case ZZOrderStatusComplete:
            self.statusLabel.text = @"已参加";

            break;
        case ZZOrderStatusExpired:
            self.statusLabel.text = @"已过期";

            break;
        case ZZOrderStatusEvaluation:
            self.statusLabel.text = @"已评价";

            break;
        case ZZOrderStatusRefund:
            self.statusLabel.text = @"已退款";

            break;
        case ZZOrderStatusCancel:
            self.statusLabel.text = @"已取消";
            break;

    }
    
    if (order.status == ZZOrderStatusNotPaid) {
        [self.cancelBT setTitle:@"立即支付"];
    }else if (order.status == ZZOrderStatusPaid || order.status == ZZOrderStatusExpired) {
        [self.cancelBT setTitle:@"申请退款"];
    }else if (order.status == ZZOrderStatusComplete) {
        [self.cancelBT setTitle:@"立即评价"];
    }else {
        self.cancelBT.hidden = YES;
    }
    [self.headIV  setPictureImageWithURL:order.servicesImg];
}

//订单按钮响应事件
- (IBAction)didClickOnCaneclButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickOnCell:andOrderStatus:)]) {
        [self.delegate didClickOnCell:self andOrderStatus:self.order.status];
    }
    
}
@end
