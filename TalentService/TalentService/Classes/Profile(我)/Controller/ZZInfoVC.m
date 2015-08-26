//
//  ZZInfoVC.m
//  TalentService
//
//  Created by charles on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZInfoVC.h"

@interface ZZInfoVC ()
@property (strong, nonatomic) IBOutlet UIScrollView *infoScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *infoIV;

@end

@implementation ZZInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoScrollView.backgroundColor = backGroundColor;
    self.infoScrollView.contentSize = CGSizeMake(ScreenWidth, 667);
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
