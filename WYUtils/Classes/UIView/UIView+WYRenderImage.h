//
//  UIView+WYRenderImage.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WYRenderImage)

- (UIImage *)wy_renderImage;
- (UIImage *)wy_renderImageWithBGColor:(UIColor *)bgColor;


@end

NS_ASSUME_NONNULL_END
