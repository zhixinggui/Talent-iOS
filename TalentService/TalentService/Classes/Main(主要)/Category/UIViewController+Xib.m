//
//  UIViewController+Xib.m
//  TalentService
//
//  Created by charles on 15/8/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UIViewController+Xib.h"

@implementation UIViewController (Xib)
- (id)initWithNib {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end
