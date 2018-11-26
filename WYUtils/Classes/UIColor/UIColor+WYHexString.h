//
//  UIColor+wp_hexString.h
//  WantedPost
//
//  Created by wyan on 2018/11/2.
//  Copyright © 2018 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (WYHexString)

+ (UIColor *)wy_colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
