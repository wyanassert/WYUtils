//
//  UIImage+WYCache.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WYCache)

+ (NSString *)wy_storeImageToLocal:(UIImage *)image;

+ (UIImage *)wy_configImageWithLocalIdentifier:(NSString *)localIdentifier;

@end

NS_ASSUME_NONNULL_END
