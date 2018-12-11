//
//  UIImage+WYMask.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WYMask)

+ (UIImage*)wy_maskImage:(UIImage *)image withMask:(UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
