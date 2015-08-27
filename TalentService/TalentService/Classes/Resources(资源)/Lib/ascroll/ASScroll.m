//
//  ASScroll.m
//  ScrollView Source control
//
//  Created by Ahmed Salah on 12/14/13.
//  Copyright (c) 2013 Ahmed Salah. All rights reserved.
//

#import "ASScroll.h"

@implementation ASScroll
@synthesize arrOfImages;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        // Initialization code
    }
    return self;
}

-(void)setArrOfImages:(NSMutableArray *)arr{
    arrOfImages = arr;
        if (arr.count>1) {
            pageControl = [[UIPageControl alloc] init];
            pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
            
            pageControl.frame = CGRectMake(self.frame.size.width- 150,self.frame.size.height-50, 122, 36);
            pageControl.numberOfPages = arrOfImages.count;
            pageControl.currentPage = 0;
            CGPoint  center = self.center;
            center.y+=65;
            pageControl.center = center;
        }
        
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollview.scrollsToTop = NO;
        scrollview.contentSize = CGSizeMake(scrollview.frame.size.width * arrOfImages.count,scrollview.frame.size.height);
   
        [scrollview setDelegate:self];
    
        scrollview.showsVerticalScrollIndicator = NO;
        scrollview.showsHorizontalScrollIndicator = NO;
        scrollview.pagingEnabled = YES;
        
        [self performSelector:@selector(startAnimatingScrl) withObject:nil afterDelay:3.0];
    
        for (int i =0; i<arrOfImages.count ; i++) {
            UIImageView * imageview = [arrOfImages objectAtIndex:i];
            imageview.clipsToBounds = YES;
            [imageview setContentMode:UIViewContentModeScaleAspectFill];
            imageview.frame = CGRectMake(i*scrollview.frame.size.width, 0.0,scrollview.frame.size.width , scrollview.frame.size.height);
            //[imageview setTag:i+1];
            imageview.userInteractionEnabled = YES;
//            if (i !=0) {
//                imageview.alpha = 0;
//            }
           [scrollview addSubview:imageview];
          
        }
      [self addSubview:scrollview];
        [self addSubview:pageControl];


}
- (void)startAnimatingScrl
{
    if (arrOfImages.count) {
      [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage +1)%arrOfImages.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
        [pageControl setCurrentPage:((pageControl.currentPage +1)%arrOfImages.count)];
        [self performSelector:@selector(startAnimatingScrl) withObject:nil  afterDelay:3.0];
    }
}
-(void) cancelScrollAnimation{
    didEndAnimate =YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimatingScrl) object:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    previousTouchPoint = scrollView.contentOffset.x;
    [self cancelScrollAnimation];
}

//- (void)pgCntlChanged:(UIPageControl *)sender {
//    [scrollview scrollRectToVisible:CGRectMake(sender.currentPage*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
//    [self cancelScrollAnimation];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

  // [self performSelector:@selector(startAnimatingScrl) withObject:nil afterDelay:3.0];
    
//    CGRect visiableRect = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.bounds.size.width, scrollView.bounds.size.height);
//    NSInteger currentIndex = 0;
//    for (UIImageView *imageView in scrollView.subviews) {
//        if ([imageView isKindOfClass:[UIImageView class]]) {
//            if (CGRectContainsRect(visiableRect, imageView.frame)) {
//                currentIndex = imageView.tag ;
//                break;
//            }
//        }
//    }
//    
//   pageControl.currentPage = currentIndex;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView.contentOffset.x<0) {
//        scrollView.contentOffset = CGPointMake(scrollView.width*(arrOfImages.count-1), 0);
//        
//    }else if (scrollView.contentOffset.x>scrollView.width*(arrOfImages.count-1)){
//        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }

//    CGPoint offset = scrollView.contentOffset;
//    if(offset.x<0){
//        offset.x = scrollview.frame.size.width * (arrOfImages.count-1);
//       scrollView.contentOffset = offset;
//        NSUInteger index = round(offset.x / scrollView.frame.size.width);
//        pageControl.currentPage = index;
//        scrollview.scrollEnabled = NO;
//    }
//    
//    if (offset.x>scrollview.frame.size.width * (arrOfImages.count-1)) {
//        
//               offset.x = 0;
//               scrollView.contentOffset = offset;
//        NSUInteger index = round(offset.x / scrollView.frame.size.width);
//        pageControl.currentPage = index;
//        scrollview.scrollEnabled = NO;
//    }
//    NSUInteger index = round(offset.x / scrollView.frame.size.width);
//    pageControl.currentPage = index;
//    scrollview.scrollEnabled = YES;
  
    
    int page = scrollview.bounds.origin.x/scrollview.frame.size.width;
 
    if (previousTouchPoint > scrollView.contentOffset.x)
        page = page+2;
    else
        page = page+1;
    
    UIView *nextPage = [scrollView.superview viewWithTag:page+1];
    UIView *previousPage = [scrollView.superview viewWithTag:page-1];
    UIView *currentPage = [scrollView.superview viewWithTag:page];
//
//    if(previousTouchPoint <= scrollView.contentOffset.x){
//        if ([currentPage isKindOfClass:[UIImageView class]])
//            currentPage.alpha = 1-alpha;
//        if ([nextPage isKindOfClass:[UIImageView class]])
//            nextPage.alpha = 1;
//        if ([previousPage isKindOfClass:[UIImageView class]])
//            previousPage.alpha = 1;
//    }else if(page != 0){
//        if ([currentPage isKindOfClass:[UIImageView class]])
//            currentPage.alpha = alpha;
//        if ([nextPage isKindOfClass:[UIImageView class]])
//            nextPage.alpha = 0;
//        if ([previousPage isKindOfClass:[UIImageView class]])
//            previousPage.alpha = 1-alpha;
//    }
    if (didEndAnimate) {
   
         [pageControl setCurrentPage:scrollview.bounds.origin.x/scrollview.frame.size.width];
    }
//    if (!didEndAnimate && pageControl.currentPage == 0) {
//        for (UIView * imageView in self.subviews){
//            if (imageView.tag !=1 && [imageView isKindOfClass:[UIImageView class]])
//                imageView.alpha = 0;
//            else if([imageView isKindOfClass:[UIImageView class]])
//                imageView.alpha = 1 ;
//        }
//    }

}

-(void)dealloc{
 
    [self cancelScrollAnimation];
    scrollview.delegate = nil;
}

@end
