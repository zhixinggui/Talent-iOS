//
//  ZZFirstLoginVC.m
//  TalentService
//
//  Created by charles on 15/8/18.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZFirstLoginVC.h"
#import "ZZTextField.h"
@interface ZZFirstLoginVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *phoneNumTF;
@property (strong, nonatomic) IBOutlet ZZTextField *secrectTF;

@end

@implementation ZZFirstLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  给textfield的leftview设置图片
     */
    [self.phoneNumTF addLeftViewImageString:@"user"];
    [self.secrectTF addLeftViewImageString:@"user"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
