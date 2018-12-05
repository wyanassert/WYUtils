//
//  UINavigationBar+WYBottomBorderColor.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/12/5.
//

#import "UINavigationBar+WYBottomBorderColor.h"

@implementation UINavigationBar (WYBottomBorderColor)

- (void)wy_configBottomBorderColor:(UIColor *)color height:(CGFloat)height {
    CGRect bottomBorderRect = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), height);
    UIView *bottomBorder = [[UIView alloc] initWithFrame:bottomBorderRect];
    [bottomBorder setBackgroundColor:color];
    [self addSubview:bottomBorder];
}

@end
