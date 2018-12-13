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

@end

NS_ASSUME_NONNULL_END
