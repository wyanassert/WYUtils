//
//  UIImage+WYShrink.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/12/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WYShrink)

- (UIImage *)wy_shrinkImageWithRecommendSize:(CGSize)targetSize;

- (UIImage *)wy_shrinkImageWithRecommendSize:(CGSize)targetSize withScale:(CGFloat)sizeScale;

- (UIImage *)wy_shrinkImageWithRecommendSizeForScale:(CGSize)targetSize;

+ (UIImage *)wy_imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (UIImage *)wy_imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize andScale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
