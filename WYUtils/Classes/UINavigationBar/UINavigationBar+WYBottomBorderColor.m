//
//  UINavigationBar+WYBottomBorderColor.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/12/5.
//

#import "UINavigationBar+WYBottomBorderColor.h"

@interface WYNaviBottomView : UIView

@end

@implementation WYNaviBottomView

@end

@implementation UINavigationBar (WYBottomBorderColor)

- (void)wy_configBottomBorderColor:(UIColor *)color height:(CGFloat)height {
    [self wy_removeBottomBorderView];
    CGRect bottomBorderRect = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), height);
    UIView *bottomBorder = [[WYNaviBottomView alloc] initWithFrame:bottomBorderRect];
    [bottomBorder setBackgroundColor:color];
    [self addSubview:bottomBorder];
}

- (void)wy_removeBottomBorderView {
    for (UIView *view in self.subviews.copy) {
        if([view isKindOfClass:[WYNaviBottomView class]]) {
            [view removeFromSuperview];
        }
    }
}

@end
