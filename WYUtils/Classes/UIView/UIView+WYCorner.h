//
//  UIView+RPCorner.h
//  RecordPost
//
//  Created by wyan on 2018/8/17.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WYCorner)

- (void)wy_addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;

- (void)wy_addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii viewRect:(CGRect)rect;
- (void)wy_addRoundedCornerTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight;

@end
