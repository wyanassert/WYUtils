//
//  UIImage+SpilteNine.h
//  PhotoGrid
//
//  Created by wyan on 2018/9/7.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WYBlur)

+ (UIImage *)wy_blurredImageWithImage:(UIImage *)sourceImage withBlur:(CGFloat)blur;

@end

NS_ASSUME_NONNULL_END
