//
//  UIImage+WYMask.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/12/11.
//

#import "UIImage+WYMask.h"

@implementation UIImage (WYMask)

+ (UIImage*)wy_maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGSize size0 = CGSizeMake(image.size.width * image.scale, image.size.height * image.scale);
    CGSize size1 = CGSizeMake(maskImage.size.width * maskImage.scale, maskImage.size.height * maskImage.scale);
    
    CGFloat scale = MIN(size0.width / size1.width, size0.height/size1.height);
    
    CGRect rect = CGRectMake((size0.width - scale * size1.width)/2, (size0.height - scale * size1.height)/2, scale * size1.width, scale * size1.height);
    CGRect rect0;
    CGRect rect1;
    if(size0.height/size1.height < size0.width / size1.width) {
        rect0 = CGRectMake(0, 0, (size0.width - rect.size.width)/2, size0.height);
        rect1 = CGRectMake((size0.width + rect.size.width)/2, 0, (size0.width - rect.size.width)/2, size0.height);
    } else {
        rect0 = CGRectMake(0, 0, size0.width, (size0.height - rect.size.height)/2);
        rect1 = CGRectMake(0, (size0.height + rect.size.height)/2, size0.width, (size0.height - rect.size.height)/2);
    }
    
    UIGraphicsBeginImageContextWithOptions(size0, NO, 0.0);
    [[UIColor clearColor] set];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(rect0);
    UIRectFill(rect1);
    
    [maskImage drawInRect:rect];
    maskImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    CGImageRef maskedImageRef = CGImageCreateWithMask([image CGImage], mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedImageRef];
    
    CGImageRelease(mask);
    CGImageRelease(maskedImageRef);
    
    // returns new image with mask applied
    return maskedImage;
}

@end
