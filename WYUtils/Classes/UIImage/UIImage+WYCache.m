//
//  UIImage+WYCache.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/11/6.
//

#import "UIImage+WYCache.h"


@implementation UIImage (WYCache)

+ (NSString *)wy_storeImageToLocal:(UIImage *)image {
    
    NSString *localIdentifier = [NSString stringWithFormat:@"image_%f.jpg", [NSDate timeIntervalSinceReferenceDate]];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    NSString *imagePath = [UIImage wy_docPathForImageName:localIdentifier];
    
    [imageData writeToFile:imagePath atomically:YES];
    
    return localIdentifier;
}

+ (UIImage *)wy_configImageWithLocalIdentifier:(NSString *)localIdentifier {
    if(!localIdentifier.length) {
        return nil;
    }
    NSString *imagePath = [UIImage wy_docPathForImageName:localIdentifier];
    UIImage *image = nil;
    if (imagePath) {
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        if(imageData) {
            image = [UIImage imageWithData:imageData];
        }
    }
    return image;
}

+ (NSString *)wy_docPathForImageName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

@end
