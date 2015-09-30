//
//  ZZJoinOrderCell.m
//  TalentService
//
//  Created by charles on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZJoinOrderCell.h"

@interface ZZJoinOrderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;

@end

@implementation ZZJoinOrderCell
- (void)awakeFromNib {
    self.headIV.contentMode = UIViewContentModeScaleAspectFill;
    self.headIV.clipsToBounds = YES;
}

#pragma mark - Setters andGetters
- (void)setOrder:(ZZOrder *)order {
    _order = order;
    self.titleLabel.text = order.title;
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单号: %@",order.orderCode];
    self.orderTimeLabel.text = [NSString stringWithFormat:@"订单时间:%@",order.orderDate];
    switch (order.status) {
        case ZZOrderStatusNotPaid:
            self.orderStatus.text = @"未支付";
            break;
            
        case ZZOrderStatusPaid:
            self.orderStatus.text = @"已支付";
            break;
            
        case ZZOrderStatusComplete:
            self.orderStatus.text = @"已参加";
            break;
            
        case ZZOrderStatusExpired:
            self.orderStatus.text = @"已过期";
            break;
            
        case ZZOrderStatusEvaluation:
            self.orderStatus.text = @"已评价";
            break;
            
        case ZZOrderStatusRefund:
            self.orderStatus.text = @"已退款";
            break;
            
        case ZZOrderStatusCancel:
            self.orderStatus.text = @"已取消";
            break;
    }
    [self.headIV  setPictureImageWithURL:order.servicesImg];
}


@end
