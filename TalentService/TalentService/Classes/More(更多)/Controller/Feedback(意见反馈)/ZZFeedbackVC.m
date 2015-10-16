//
//  ZZFeedbackVC.m
//  TalentService
//
//  Created by charles on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZFeedbackVC.h"

@interface ZZFeedbackVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextView *textViewTV;

@end

@implementation ZZFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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



@end
