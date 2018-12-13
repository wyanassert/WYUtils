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

@end
