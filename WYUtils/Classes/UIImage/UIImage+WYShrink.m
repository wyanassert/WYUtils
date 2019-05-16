//
//  UIImage+WYShrink.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/12/13.
//

#import "UIImage+WYShrink.h"

@implementation UIImage (WYShrink)

- (UIImage *)wy_shrinkImageWithRecommendSize:(CGSize)targetSize {
    
    if(self.size.width * self.scale > targetSize.width || self.size.height * self.scale > targetSize.height) {
        CGFloat scale = MAX(self.size.width * self.scale / targetSize.width, self.size.height * self.scale/targetSize.height);
        CGSize size = CGSizeMake(self.size.width * self.scale / scale, self.size.height * self.scale / scale);
        UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    } else {
        return self;
    }
}

+ (UIImage *)wy_imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    return [UIImage wy_imageWithImage:image scaledToSize:newSize andScale:[UIScreen mainScreen].scale];
}

+ (UIImage *)wy_imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize andScale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

@end
