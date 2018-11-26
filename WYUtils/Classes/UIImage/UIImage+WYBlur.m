//
//  UIImage+SpilteNine.m
//  PhotoGrid
//
//  Created by wyan on 2018/9/7.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import "UIImage+WYBlur.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (WYBlur)

+ (UIImage *)wy_blurredImageWithImage:(UIImage *)sourceImage withBlur:(CGFloat)blur {
    
    //  Create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    //  Setting up Gaussian Blur
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:100*blur] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
     *  up exactly to the bounds of our original image */
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *retVal = [UIImage imageWithCGImage:cgImage];
    return retVal;
}

@end
