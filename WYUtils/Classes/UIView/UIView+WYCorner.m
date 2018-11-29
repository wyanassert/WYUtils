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
    
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)wy_addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii viewRect:(CGRect)rect {
    
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)wy_addRoundedCornerTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight {
    UIBezierPath *rounded = [UIBezierPath bezierPath];
    
    CGSize size = self.bounds.size;
    
    [rounded moveToPoint:CGPointMake(0, size.height - bottomLeft)];
    
    [rounded addLineToPoint:CGPointMake(0, topLeft)];
    [rounded addArcWithCenter:CGPointMake(topLeft, topLeft) radius:topLeft startAngle:M_PI endAngle:M_PI*1.5 clockwise:YES];
    
    [rounded addLineToPoint:CGPointMake(size.width - topRight, 0)];
    [rounded addArcWithCenter:CGPointMake(size.width - topRight, topRight) radius:topRight startAngle:M_PI*1.5 endAngle:0 clockwise:YES];
    
    [rounded addLineToPoint:CGPointMake(size.width, size.height - bottomRight)];
    [rounded addArcWithCenter:CGPointMake(size.width - bottomRight, size.height - bottomRight) radius:bottomRight startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [rounded addLineToPoint:CGPointMake(bottomLeft, size.height)];
    [rounded addArcWithCenter:CGPointMake(bottomLeft, size.height - bottomLeft) radius:bottomLeft startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

@end
