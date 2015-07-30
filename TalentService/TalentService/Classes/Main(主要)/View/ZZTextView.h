//
//  ZZTextView.h
//  萌宝派
//
//  Created by zhizhen on 15-3-6.
//  Copyright (c) 2015年 shanghaizhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTextView;

@protocol  ZZTextViewDelegate <UITextViewDelegate>

@end


@interface ZZTextView : UITextView
/**
 *  占位字符串
 */
@property (nonatomic, strong) NSString*  placeholder;

/**
 *  最多的输入内容，字符
 */
@property(nonatomic) NSUInteger  textContentLength;

@property (nonatomic, weak) id<ZZTextViewDelegate>  delegate;

@end
