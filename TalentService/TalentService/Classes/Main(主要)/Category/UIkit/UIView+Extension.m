//
//  UIView+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UIView+Extension.h"

static CGFloat const vOffsetX = 10;
static CGFloat const vDuration = 0.06;
static NSUInteger const vRepeatCount = 3;

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (NSUInteger)getSubviewIndex {
    return [self.superview.subviews indexOfObject:self];
}

- (void)bringToFront {
    [self.superview bringSubviewToFront:self];
}

- (void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}

- (void)bringOneLevelUp {
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

- (void)sendOneLevelDown {
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

- (BOOL)isInFront {
    return ([self.superview.subviews lastObject]==self);
}

- (BOOL)isAtBack {
    return ([self.superview.subviews objectAtIndex:0]==self);
}

- (void)swapDepthsWithView:(UIView*)swapView {
    [self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}

- (void)removeAllSubviews {
    // Normally.
    //    for(UIView *view in [self subviews]) {
    //        [view removeFromSuperview];
    //    }
    
    // But others.
    //    [self setSubviews:[NSArray array]]; // If subviews can be written.
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)removeSubViewByTag:(NSUInteger)tag {
    UIView *v = nil;
    if ((v = [self viewWithTag:tag])) {
        [v removeFromSuperview];
    }
}

- (void)removeSubViews:(NSArray *)views {
    if (views && [views count]) {
      
        [views makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}

- (BOOL)containsSubView:(UIView *)subView {
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsSubViewOfClassType:(Class)classt {
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:classt]) {
            return YES;
        }
    }
    return NO;
}
- (NSMutableAttributedString *)getAttributedStringWithText:(NSString *)text paragraphSpacing:(CGFloat)paragraphSpacing lineSpace:(CGFloat)lineSpace stringCharacterSpacing:(CGFloat)stringCharacterSpacing  textAlignment:(NSTextAlignment) textAlignment font:(UIFont *)font  color:(UIColor *)color{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString   alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle  alloc] init];
    paragraphStyle.alignment = textAlignment;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    if (lineSpace<0) {
        lineSpace = 0;
    }
    if (paragraphSpacing < 0) {
        paragraphSpacing = 0;
    }
    paragraphStyle.lineSpacing = lineSpace;  //行自定义行高度
    paragraphStyle.paragraphSpacing = paragraphSpacing;  //段间距
    // [paragraphStyle setFirstLineHeadIndent:self.usernameLabel.frame.size.width + 5];//首行缩进 根据用户昵称宽度在加5个像素
    NSRange range = NSMakeRange(0,attributedString.length);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    //字体大小
    if (font) {
        [attributedString  addAttributes:@{NSFontAttributeName:font} range:range];
    }
    if (color) {
        [attributedString  addAttributes:@{NSForegroundColorAttributeName :color} range:range];
    }
    //字间距
    long number = stringCharacterSpacing;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedString addAttribute:NSKernAttributeName value:(__bridge id)num range:range];
    CFRelease(num);
    
    
    return attributedString;
}
- (NSMutableAttributedString *)getAttributedStringWithText:(NSString *)text  textFont:(UIFont *)textFont  textColor:(UIColor *)textColor   content:(NSString *)content  contentFont:(UIFont *)contentFont  contentColor:(UIColor *)contentColor {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString   alloc] initWithString:[NSString  stringWithFormat:@"%@ %@",text,content]];
 
    NSRange textRange = NSMakeRange(0,text.length);
        [attributedString  addAttributes:@{NSFontAttributeName:textFont} range:textRange];
        [attributedString  addAttributes:@{NSForegroundColorAttributeName :textColor} range:textRange];

    NSRange contentRange = NSMakeRange(text.length+1,content.length);
    [attributedString  addAttributes:@{NSFontAttributeName:contentFont} range:contentRange];
    [attributedString  addAttributes:@{NSForegroundColorAttributeName :contentColor} range:contentRange];
    return attributedString;
}

- (void)shakeAnimation:(CGFloat)offsetX duration:(CGFloat)duration repeatCount:(NSUInteger)repeatCount

{
    offsetX = offsetX > 0 ? offsetX : vOffsetX;
    duration = duration > 0 ? duration : vDuration;
    repeatCount = repeatCount > 0 ? repeatCount : vRepeatCount;
    // 获取到当前的View
    CALayer *viewLayer = self.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + offsetX, position.y);
    CGPoint y = CGPointMake(position.x - offsetX, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:duration];
    // 设置次数
    [animation setRepeatCount:repeatCount];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}
@end
