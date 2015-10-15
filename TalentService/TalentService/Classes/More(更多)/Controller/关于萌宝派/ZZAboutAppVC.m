//
//  ZZAboutAppVC.m
//  TalentService
//
//  Created by zhizhen on 15/10/15.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZAboutAppVC.h"

@interface ZZAboutAppVC ()
@property (weak, nonatomic) IBOutlet UIButton *ruleButton;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ZZAboutAppVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于萌宝派";
    [self  setChildInterface];
   
}

- (void)setChildInterface{
    
    self.versionLabel.text = @"萌宝派(beta1)";
    self.contentLabel.text = @"      萌宝派，为每一位父母送上最新鲜热辣的育儿资讯，预告最丰富有趣的亲子活动，解答所有棘手或细碎的孕、育问题。萌宝派，最酷、最炫、最好用的掌上育儿宝典，期待你的加入！";
    //上海至臻文化传媒股份有限公司
    //Shanghai Tops Media Communication Co., Ltd.
    //Copyright 2015 All Rights Reserved
    NSString* str1 = @"上海至臻文化传媒股份有限公司\n";
    NSString* str2 = @"Shanghai Tops Media Communication Co., Ltd.\n";
    NSString* str3 = @"Copyright 2015 All Rights Reserved";
    
    NSString* strAll = [[str1  stringByAppendingString:str2]stringByAppendingString:str3];
     NSRange range1 = NSMakeRange(0, str1.length);
     NSRange range2 = NSMakeRange(range1.location+range1.length, str2.length);
     NSRange range3 = NSMakeRange(range2.location+range2.length, str3.length);
     NSMutableAttributedString * companyAttribute = [[NSMutableAttributedString alloc]initWithString:strAll];
    //str1
    [ companyAttribute addAttribute:NSForegroundColorAttributeName value:ZZDarkGrayColor range:range1];
    [ companyAttribute addAttribute:NSFontAttributeName value:[UIFont  boldSystemFontOfSize:16] range:range1];
    //str2
    [ companyAttribute addAttribute:NSForegroundColorAttributeName value:ZZDarkGrayColor range:range2];
    [ companyAttribute addAttribute:NSFontAttributeName value:[UIFont  systemFontOfSize:14] range:range2];
    //str3
    [ companyAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor  lightGrayColor] range:range3];
    [ companyAttribute addAttribute:NSFontAttributeName value:[UIFont  systemFontOfSize:12] range:range3];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle  alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.paragraphSpacing = 3;  //段间距
paragraphStyle.alignment = NSTextAlignmentCenter;
    NSRange rangeAll = NSMakeRange(0,strAll.length);
    [companyAttribute addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:rangeAll];
    self.companyLabel.attributedText = companyAttribute;
    //服务与条款协议
    NSMutableAttributedString * attribute = [[NSMutableAttributedString alloc]initWithString:@"服务条款与协议"];
    NSRange range = NSMakeRange(0, attribute.string.length);
   [ attribute addAttribute:NSForegroundColorAttributeName value:[UIColor  blueColor] range:range];
    [ attribute addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:range];
    [ attribute addAttribute:NSFontAttributeName value:[UIFont  systemFontOfSize:12] range:range];
    [self.ruleButton  setAttributedTitle:attribute forState:UIControlStateNormal];
}
- (IBAction)ruleButtonAction:(UIButton *)sender {
}

@end
