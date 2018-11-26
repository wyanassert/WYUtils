//
//  UIImage+WYColor.n
//  GxUniversal
//
//  Created by Wade Wei on 23/11/2017.
//  Copyright © 2017 makeupopular.com. All rights reserved.
//
#import "UIImage+WYColor.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (WYColor)

- (UIImage *)wy_colored:(UIColor *)color
{
    return [UIImage wy_imageWithImage:self withTintColor:color];
}

- (UIImage *)wy_coloredWithGradient:(NSArray *)colors
{
    return [self wy_coloredWithGradient:colors startPoint:CGPointMake(0.5,0) endPoint:CGPointMake(0.5, 1)];
}

- (UIImage *)wy_coloredWithGradient:(NSArray *)colors startPoint:(CGPoint)start endPoint:(CGPoint)end
{
    CGSize size = self.size;
    
    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, 0, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextDrawImage(context, rect, self.CGImage);
    
    // Create gradient
    NSMutableArray *cgcolors = [NSMutableArray new];
    for (UIColor *color in colors) {
        [cgcolors addObject:(id)color.CGColor];
    }
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)cgcolors, NULL);
    
    // Apply gradient
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(size.width * start.x, size.height * (1.0-start.y)), CGPointMake(size.width * end.x, size.height * (1.0-end.y)), 0);
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
    return gradientImage;
}

+ (UIImage *)wy_imageWithColor:(UIColor *)color withCenter:(UIImage *)centerImage size:(CGSize)size
{
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    [background setBackgroundColor:color];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:centerImage];
    [background addSubview:imageView];
    imageView.center = background.center;
    
    // Render image
    UIGraphicsBeginImageContextWithOptions(background.bounds.size, background.opaque, 0.0);
    [background.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}

+ (UIImage *)wy_imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)wy_imageWithColor:(UIColor *)color
{
    return [UIImage wy_imageWithColor:color size:CGSizeMake(10, 10)];
}

+ (UIImage *)wy_imageNamed:(NSString *)name withTintColor:(UIColor *)color {
    
    UIImage *img = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    [color set];
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)wy_imageWithImage:(UIImage *)image withTintColor:(UIColor *)color
{
    UIImage *img = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    [color set];
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)wy_makeImageWithView:(UIView *)view
{
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)wy_imageWithLinearColors:(NSArray *)colors
                  startPoint:(CGPoint)startPoint
                    endPoint:(CGPoint)endPoint {
    return [self wy_imageWithLinearColors:colors startPoint:startPoint endPoint:endPoint size:CGSizeMake(40.f, 40.f)];
}

+ (UIImage *)wy_imageWithLinearColors:(NSArray *)colors
                  startPoint:(CGPoint)startPoint
                    endPoint:(CGPoint)endPoint
                        size:(CGSize)size {
    
    return [self wy_imageWithLinearColors:colors startPoint:startPoint endPoint:endPoint size:size locations:@[@(0.f), @(1.f)]];
}

+ (UIImage *)wy_imageWithLinearColors:(NSArray *)colors
                  startPoint:(CGPoint)startPoint
                    endPoint:(CGPoint)endPoint
                        size:(CGSize)size
                   locations:(NSArray<NSNumber *> *)locations {
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat *rLocations;
    if (locations.count > 0) {
        
        rLocations = (CGFloat *)malloc(sizeof(CGFloat) * locations.count);
        for (int i = 0; i < locations.count; i++) {
            rLocations[i] = locations[i].floatValue;
        }
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, rLocations);
    float (^floatBlock)(float) = ^(float x) {
        
        if (x <= 0.f) {
            return 0.f;
        } else if (x >= 1.f) {
            return 1.f;
        } else {
            return x;
        }
    };
    CGPoint rsPoint = CGPointMake(floatBlock(startPoint.x) * size.width, floatBlock(startPoint.y) * size.height);
    CGPoint rePoint = CGPointMake(floatBlock(endPoint.x) * size.width, floatBlock(endPoint.y) * size.height);
    CGContextDrawLinearGradient(context, gradient, rsPoint, rePoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)wy_imageWithRadialColors:(NSArray *)colors {
    return [self wy_imageWithRadialColors:colors size:CGSizeMake(40.f, 40.f)];
}

+ (UIImage *)wy_imageWithRadialColors:(NSArray *)colors
                              size:(CGSize)size {
    return [self wy_imageWithRadialColors:colors size:size locations:@[@(0.f), @(1.f)]];
}

+ (UIImage *)wy_imageWithRadialColors:(NSArray *)colors
                              size:(CGSize)size
                         locations:(NSArray<NSNumber *> *)locations {
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat *rLocations;
    if (locations.count > 0) {
        
        rLocations = (CGFloat *)malloc(sizeof(CGFloat) * locations.count);
        for (int i = 0; i < locations.count; i++) {
            rLocations[i] = locations[i].floatValue;
        }
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, rLocations);
    CGPoint center = CGPointMake(size.width * .5f, size.height * .5f);
    CGFloat radius = size.width > size.height ? size.width * .5f : size.height * .5f;
    CGContextDrawRadialGradient(context, gradient, center, 0.f, center, radius, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
