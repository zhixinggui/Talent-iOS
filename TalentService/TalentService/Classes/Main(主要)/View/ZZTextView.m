//
//  ZZTextView.m
//  萌宝派
//
//  Created by zhizhen on 15-3-6.
//  Copyright (c) 2015年 shanghaizhizhen. All rights reserved.
//

#import "ZZTextView.h"
@interface ZZTextView ()
@property (nonatomic, strong) UILabel*  placeholderLabel;
@property (nonatomic, strong) UILabel*  tipCountLabel;
@end
@implementation ZZTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        [self  setInterFace];
    }
    return self;
}


-(void)awakeFromNib{
    
     [self  setInterFace];
}

/**初始化属性*/
- (void)setInterFace{
    self.scrollsToTop = NO;
   // self.layer.borderColor = [UIColor  colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
   // self.layer.borderWidth = 0.5;
   // self.layer.masksToBounds = YES;
    //self.layer.cornerRadius = 5;
    self.enablesReturnKeyAutomatically = YES;
    self.autocorrectionType=UITextAutocorrectionTypeNo;
    self.showsVerticalScrollIndicator=NO;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.alwaysBounceVertical = YES;
    self.layoutManager.allowsNonContiguousLayout=NO;
    
    [[NSNotificationCenter   defaultCenter]addObserver:self selector:@selector(textViewDidChangeNoti:) name:UITextViewTextDidChangeNotification object:self];
    
    self.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
}
- (void)textViewDidChangeNoti:(NSNotification *)noti{
    if (self.placeholder.length) {
        [self  updatePlaceholderLabelStatus];
    }
    [self  updateTipCountLabelText];
    UITextView *textView = noti.object;
        CGRect line = [textView caretRectForPosition:
                       textView.selectedTextRange.start];
        CGFloat overflow = line.origin.y + line.size.height
        - ( textView.contentOffset.y + textView.bounds.size.height
           - textView.contentInset.bottom - textView.contentInset.top );
        if ( overflow > 0 ) {
            // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
            // Scroll caret to visible area
            CGPoint offset = textView.contentOffset;
            offset.y += overflow + 7.5; // leave 7 pixels margin
            // Cannot animate with setContentOffset:animated: or caret will not appear
            [UIView animateWithDuration:.3 animations:^{
                [textView setContentOffset:offset];
            }];
        }
   
    /**超出长度不让输入*/
//    UITextRange *selectedRange = [self markedTextRange];
//    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
//    NSInteger offset = [self offsetFromPosition:position toPosition:[self positionFromPosition:selectedRange.end offset:0]];
//    NSString *text = [self.text substringToIndex:(self.text.length -offset)];
//    if (self.textContentLength&&text.length > self.textContentLength/2) {
//      
//        NSInteger textLength = [text  unicodeLength] - offset;
//        if (textLength <= self.textContentLength||textLength <0 ) {
//            return;
//        }else{
//            for (NSUInteger lenth = self.textContentLength/2; lenth < textLength; lenth++) {
//                if ([[text  substringToIndex:lenth] unicodeLength] > self.textContentLength) {
//                    self.text = [text  substringToIndex:lenth-1];
//                    break;
//                }
//            }
//        }
//
//    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.placeholder.length) {
        self.placeholderLabel.y = 8;
        self.placeholderLabel.x = 5;
        self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
        // 根据文字计算label的高度
        CGSize placehoderSize = [self.placeholder sizeWithFont:self.placeholderLabel.font maxW:self.placeholderLabel.width];
        self.placeholderLabel.height = placehoderSize.height;
        [self  updatePlaceholderLabelStatus];
    }
    
    if (self.textContentLength) {
            CGFloat labelHeight = 16;
            CGFloat  labelXOffet =10;
            self.tipCountLabel.frame = CGRectMake(10, self.height-labelHeight, self.width - labelXOffet*2, labelHeight);
          [self  updateTipCountLabelText];
    }
}


-(void)dealloc{
    [[NSNotificationCenter  defaultCenter]removeObserver:self ];
}

- (void)updateTipCountLabelText{
    CGFloat labelHeight = 14;
    CGFloat  labelXOffet =5;
    
    CGFloat height = self.height;
    if (self.contentSize.height>height) {
        height = self.contentSize.height;
    }
    self.tipCountLabel.frame = CGRectMake(labelXOffet, height-16, self.width - labelXOffet*2, labelHeight);
    
  NSUInteger textCount =  [self.text unicodeLength];
    self.tipCountLabel.text = [NSString  stringWithFormat:@"%lu / %lu",textCount/2,self.textContentLength/2];
}
-(void)updatePlaceholderLabelStatus{
        if (self.text.length) {
            self.placeholderLabel.hidden = YES;
        }else{
            self.placeholderLabel.hidden = NO;
        }
}
#pragma mark -set
-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {//WithFrame:CGRectMake(5,5, self.frame.size.width-20, 15)
        _placeholderLabel = [[UILabel  alloc]init];
        _placeholderLabel.font = [UIFont  systemFontOfSize:14];
        _placeholderLabel.textColor = [UIColor   colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return _placeholderLabel;
}
-(void)setTextContentLength:(NSUInteger)textContentLength{
    _textContentLength= textContentLength;
    [self  addSubview:self.tipCountLabel];
}
-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length) {
        _placeholder = placeholder ;
        [self  addSubview:self.placeholderLabel];
        self.placeholderLabel.text = placeholder  ;
    }
}
-(UILabel *)tipCountLabel{
    if (_tipCountLabel == nil) {
        _tipCountLabel = [[UILabel  alloc]init];
        _tipCountLabel.textAlignment = NSTextAlignmentRight;
        _tipCountLabel.font = [UIFont  systemFontOfSize:12];
        _tipCountLabel.textColor = ZZLightGrayColor;
    
    }
    return _tipCountLabel;
}


@end
