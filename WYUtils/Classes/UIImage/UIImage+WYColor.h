//
//  UIImage+WYColor.h
//  GxUniversal
//
//  Created by Wade Wei on 23/11/2017.
//  Copyright © 2017 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GXColor)

- (UIImage *)wy_colored:(UIColor *)color;

- (UIImage *)wy_coloredWithGradient:(NSArray *)colors;

/**
 Tint image with linear gradient
 @param start range 0 ~ 1
 @param end range 0 ~ 1
 @return image
 */
- (UIImage *)wy_coloredWithGradient:(NSArray *)colors startPoint:(CGPoint)start endPoint:(CGPoint)end;

+ (UIImage *)wy_imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)wy_imageWithColor:(UIColor *)color;

+ (UIImage *)wy_imageWithColor:(UIColor *)color withCenter:(UIImage *)centerImage size:(CGSize)size;

+ (UIImage *)wy_imageNamed:(NSString *)name withTintColor:(UIColor *)color;

+ (UIImage *)wy_imageWithImage:(UIImage *)image withTintColor:(UIColor *)color;

+ (UIImage *)wy_makeImageWithView:(UIView *)view;

+ (UIImage *)wy_imageWithLinearColors:(NSArray *)colors
                        startPoint:(CGPoint)startPoint
                          endPoint:(CGPoint)endPoint;

+ (UIImage *)wy_imageWithLinearColors:(NSArray *)colors
                  startPoint:(CGPoint)startPoint
                    endPoint:(CGPoint)endPoint
                        size:(CGSize)size;

+ (UIImage *)wy_imageWithLinearColors:(NSArray *)colors
                  startPoint:(CGPoint)startPoint
                    endPoint:(CGPoint)endPoint
                        size:(CGSize)size
                   locations:(NSArray<NSNumber *> *)locations;

+ (UIImage *)wy_imageWithRadialColors:(NSArray *)colors;

+ (UIImage *)wy_imageWithRadialColors:(NSArray *)colors
                              size:(CGSize)size;

+ (UIImage *)wy_imageWithRadialColors:(NSArray *)colors
                              size:(CGSize)size
                         locations:(NSArray<NSNumber *> *)locations;


@end
