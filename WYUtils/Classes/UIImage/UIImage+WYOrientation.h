//
//  UIImage+WYOrientation.h
//  GxUniversal
//
//  Created by songbo on 14-4-23.
//  Copyright (c) 2014年 Pinssible. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WYOrientation)

- (UIImage *)wy_imageWithOrientation:(UIImageOrientation)orientation;

- (UIImage *)wy_rotate:(CGFloat)degree;

+ (UIImage *)wy_fixOrientation:(UIImage *)srcImage;

@end
