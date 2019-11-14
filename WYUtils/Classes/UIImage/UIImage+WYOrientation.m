//
//  UIImage+WYOrientation.m
//  GxUniversal
//
//  Created by Wade Wei on 23/11/2017.
//  Copyright © 2017 makeupopular.com. All rights reserved.
//

#import "UIImage+WYOrientation.h"
#import <QuartzCore/QuartzCore.h>


#define WYAngleWithDegrees(deg) (M_PI * (deg) / 180.0)

@implementation UIImage (GXOrientation)

- (UIImage *)wy_imageWithOrientation:(UIImageOrientation)orientation
{
    
    if (orientation == UIImageOrientationUp) {
        return self;
    }
    
    CGSize contextSize = self.size;
    if (orientation == UIImageOrientationLeft || orientation == UIImageOrientationRight) {
        contextSize = CGSizeMake(contextSize.height, contextSize.width);
    }
    
    contextSize = CGSizeMake(ceil(contextSize.width * self.scale) / self.scale, ceil(contextSize.width * self.scale) / self.scale);
    
    UIGraphicsBeginImageContextWithOptions(contextSize, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (orientation) {
        case UIImageOrientationUp:
            break;
        case UIImageOrientationDown:
            CGContextTranslateCTM(context, contextSize.width, contextSize.height);
            CGContextRotateCTM(context, WYAngleWithDegrees(180.f));
            break;
        case UIImageOrientationLeft:
            CGContextTranslateCTM(context, 0.f, contextSize.height);
            CGContextRotateCTM(context, WYAngleWithDegrees(-90.f));
            break;
        case UIImageOrientationRight:
            CGContextTranslateCTM(context, contextSize.width, 0.f);
            CGContextRotateCTM(context, WYAngleWithDegrees(90.f));
            break;
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            CGContextTranslateCTM(context, 0.f, contextSize.height);
            CGContextScaleCTM(context, 1.f, -1.f);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            CGContextTranslateCTM(context, contextSize.width, 0.f);
            CGContextScaleCTM(context, -1.f, 1.f);
            break;
    }
    
    [self drawInRect:CGRectMake(0.f, 0.f, self.size.width, self.size.height)];
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

- (UIImage *)wy_rotate:(CGFloat)degree
{
    CGFloat radian = degree * (M_PI/ 180);
    CGRect contextRect = CGRectMake(0, 0, self.size.width, self.size.height);
    float newSide = MAX(self.size.width, self.size.height);
    CGSize newSize =  CGSizeMake(newSide, newSide);
    
    UIGraphicsBeginImageContextWithOptions(newSize, 0, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGPoint contextCenter = CGPointMake(CGRectGetMidX(contextRect), CGRectGetMidY(contextRect));
    CGContextTranslateCTM(ctx, contextCenter.x, contextCenter.y);
    CGContextRotateCTM(ctx, radian);
    CGContextTranslateCTM(ctx, -contextCenter.x, -contextCenter.y);
    
    [self drawInRect:contextRect];
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rotatedImage;
}

+ (UIImage *)wy_fixOrientation:(UIImage *)srcImage
{
    // No-op if the orientation is already correct
    if (srcImage.imageOrientation == UIImageOrientationUp)
        return srcImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (srcImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImage.size.width, srcImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (srcImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImage.size.width, srcImage.size.height,
                                             CGImageGetBitsPerComponent(srcImage.CGImage), 0,
                                             CGImageGetColorSpace(srcImage.CGImage),
                                             CGImageGetBitmapInfo(srcImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImage.size.height,srcImage.size.width), srcImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImage.size.width,srcImage.size.height), srcImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)wy_flipImage:(UIImage *)image {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, -1, -1);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(0.,0., image.size.width, image.size.height),image.CGImage);
    UIImage *flippedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return flippedImage;
}

+ (UIImage *)wy_rotateImage:(UIImage *)image oriention:(UIImageOrientation)oriention {
    if(oriention >= UIImageOrientationUp && oriention <= UIImageOrientationRight && image.size.width) {
        CGSize size = image.size;
        if(oriention == UIImageOrientationLeft || oriention == UIImageOrientationRight) {
            size = CGSizeMake(size.height, size.width);
        }
        UIGraphicsBeginImageContext(size);
        [[UIImage imageWithCGImage:[image CGImage] scale:image.scale orientation:oriention] drawInRect:CGRectMake(0,0,size.width ,size.height)];
        UIImage* flippedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return flippedImage;
    } else {
        return image;
    }
}

@end
