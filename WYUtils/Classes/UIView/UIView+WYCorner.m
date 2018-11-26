//
//  UIView+RPCorner.m
//  RecordPost
//
//  Created by wyan on 2018/8/17.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import "UIView+WYCorner.h"

@implementation UIView (WYCorner)

- (void)wy_addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)wy_addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}


@end
