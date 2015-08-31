//
//  ZZNextRegistVC.m
//  TalentService
//
//  Created by charles on 15/8/19.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZNextRegistVC.h"
#import "ZZTextField.h"
#import "ZZLayerButton.h"
@interface ZZNextRegistVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *nameTF;
@property (strong, nonatomic) IBOutlet ZZTextField *cityTF;
@property (strong, nonatomic) IBOutlet ZZTextField *secrectTF;
@property (strong, nonatomic) IBOutlet ZZTextField *againSecrectTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *finishButton;

@end

@implementation ZZNextRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self.nameTF addLeftViewImageString:@"T2"];
    [self.cityTF addLeftViewImageString:@"T2"];
    [self.secrectTF addLeftViewImageString:@"T2"];
    [self.againSecrectTF addLeftViewImageString:@"T2"];
    
    /**
     *  设置button颜色
     */
    self.finishButton.backgroundColor = LoginButtonColor;
}



@end
