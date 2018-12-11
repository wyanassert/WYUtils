//
//  UIView+WYRenderImage.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/11/26.
//

#import "UIView+WYRenderImage.h"

@implementation UIView (WYRenderImage)

- (UIImage *)wy_renderImage {
    return [self wy_renderImageWithBGColor:[UIColor clearColor]];
}

- (UIImage *)wy_renderImageWithBGColor:(UIColor *)bgColor {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [bgColor set];
    CGContextFillRect(ctx, self.bounds);
    [self.layer renderInContext:ctx];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
