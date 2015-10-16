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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewContstraintHeigth;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *nowPayButton;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;


@end

@implementation ZZOrderCell



- (void)awakeFromNib {
    self.headIV.contentMode = UIViewContentModeScaleAspectFill;
    self.headIV.clipsToBounds = YES;
}

#pragma mark - Setters andGetters
- (void)setOrder:(ZZOrder *)order {
    self.cancelBT.hidden = NO;
    self.lineLabel.hidden = NO;
    self.viewContstraintHeigth.constant = 121;
    self.nowPayButton.hidden = YES;
    _order = order;
    self.titleLabel.text = order.title;
    if ([order.price  isEqual: @(0)]) {
        self.priceLabel.text = @"免费";
    }else {
        self.priceLabel.text = [order  showPrice:order.price];
    }
    
    switch (order.status) {
        case ZZOrderStatusNotPaid:
            self.statusLabel.text = @"未支付";
            self.nowPayButton.hidden = NO;
            break;
            
        case ZZOrderStatusPaid:
                self.statusLabel.text = @"已预订";
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
        [self.cancelBT setTitle:@"取消订单"];
    }else if (order.status == ZZOrderStatusPaid || order.status == ZZOrderStatusExpired) {
        if ([order.price isEqual:@(0)]) {
            [self.cancelBT setTitle:@"取消订单"];
        }else {
            [self.cancelBT setTitle:@"申请退款"];
        }
        
    }else if (order.status == ZZOrderStatusComplete) {
        [self.cancelBT setTitle:@"立即评价"];
    }else {
        self.cancelBT.hidden = YES;
        self.lineLabel.hidden = YES;
        self.viewContstraintHeigth.constant = 81;
    }
    [self.headIV  setPictureImageWithURL:order.servicesImg];
}

- (IBAction)nowPay:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickOnCell:order:orderStatus:)]) {
        [self.delegate didClickOnCell:self order:self.order orderStatus:0];
    }
}

//订单按钮响应事件
- (IBAction)didClickOnCaneclButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickOnCell:order:orderStatus:)]) {
        [self.delegate didClickOnCell:self order:self.order orderStatus:self.order.status];
    }
    
}
@end
