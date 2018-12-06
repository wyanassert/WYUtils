//
//  UINavigationBar+WYBottomBorderColor.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (WYBottomBorderColor)

- (void)wy_configBottomBorderColor:(UIColor *)color height:(CGFloat)height;
- (void)wy_removeBottomBorderView;

@end

NS_ASSUME_NONNULL_END
