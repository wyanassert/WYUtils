//
//  WYPageControl.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/5/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYPageControl : UIControl

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, strong) UIColor * pageIndicatorColor;
@property (nonatomic, strong) UIColor * currentPageIndicatorColor;
@property (nonatomic, assign) NSInteger currentPage;

- (instancetype)initWithFrame:(CGRect)frame indicatorMargin:(CGFloat)margin indicatorWidth:(CGFloat)indicatorWidth currentIndicatorWidth:(CGFloat)currentIndicatorWidth indicatorHeight:(CGFloat)indicatorHeight;

@end

NS_ASSUME_NONNULL_END
