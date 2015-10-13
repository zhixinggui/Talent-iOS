//
//  ZZFeedbackVC.m
//  TalentService
//
//  Created by charles on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZFeedbackVC.h"
#import "ZZIQKeyBoardTool.h"
@interface ZZFeedbackVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextView *textViewTV;

@end

@implementation ZZFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //ZZKeyBoardTool(close);
    [self setTitle:@"意见反馈"];
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.textViewTV.delegate = self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.textLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.textViewTV.text.length) {
        
    }else {
        self.textLabel.hidden = NO;
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
