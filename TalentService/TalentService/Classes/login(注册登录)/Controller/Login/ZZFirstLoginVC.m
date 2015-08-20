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
    self.title = @"登录";
    [self.phoneNumTF addLeftViewImageString:@"T3"];
    [self.secrectTF addLeftViewImageString:@"T3"];
    /**
     *  设置右button
     */
    [self setNavRightItemWithName:@"忘记密码" target:self action:@selector(didClickOnTestSelect:)];
}
/**
 *  跳转忘记密码界面
 */
- (void)didClickOnTestSelect:(id)sender {
    ZZLog(@"忘记密码");
}
/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    // 右边按钮
    NSString *rightTitle = name;
    UIButton *t = [UIButton buttonWithType:UIButtonTypeCustom];
    t.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [t setTitle:rightTitle forState:UIControlStateNormal];
    [t setFrame:CGRectMake(0, 0, 80, 20)];
    [t setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [t addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [t setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:t];
    
    //navigation左右按钮位置调节
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;//此处修改到边界的距离，请自行测试
        
        if (rightBtn)
        {
            [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightBtn]];
        }
        else
        {
            [self.navigationItem setRightBarButtonItems:@[negativeSeperator]];
        }
        
        
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:rightBtn animated:NO];
    }
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
