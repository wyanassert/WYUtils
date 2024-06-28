//
//  UIView+WYPosition.m
//  WYUtils
//
//  Created by wyan on 2024/6/17.
//
//  简易访问／设置UIView的frame及其成员

#import "UIView+WYPosition.h"

@implementation UIView (WYPosition)

- (CGFloat)getTop
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)getLeft
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)getWidth
{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)getHeight
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)getRight
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)getBottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setTop:(CGFloat)top
{
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (void)setTopIfNeeded:(CGFloat)top
{
    if ([self getTop] != top)
    {
        [self setTop:top];
    }
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect rect = self.frame;
    rect.origin.y = bottom - rect.size.height;
    self.frame = rect;
}

- (void)setLeft:(CGFloat)left
{
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (void)setRight:(CGFloat)right
{
    CGRect rect = self.frame;
    rect.origin.x = right - rect.size.width;
    self.frame = rect;
}

- (void)setLeftTop:(CGPoint)leftTop
{
    CGRect rect = self.frame;
    rect.origin.x = leftTop.x;
    rect.origin.y = leftTop.y;
    self.frame = rect;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint) point
{
    self.frame = CGRectMake(point.x, point.y, self.width, self.height);
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize) size
{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (void)setX:(CGFloat)x Y:(CGFloat)y
{
    self.frame = CGRectMake(x, y, self.width, self.height);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (void)setWidth:(CGFloat)width height:(CGFloat)height
{
    self.frame = CGRectMake(self.x, self.y, width, height);
}

// 中心点
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint rect = self.center;
    rect.x = centerX;
    self.center= rect;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint rect = self.center;
    rect.y = centerY;
    self.center= rect;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

// 横向设置，同时设定x和宽度
- (void) setLeft:(CGFloat)left width:(CGFloat)width
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(left, self.y, width, self.height);
}

// 垂直设置，同时设定y和高度
- (void) setTop:(CGFloat)top height:(CGFloat)height
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(self.x, top, self.width, height);
}

- (void) setVCenter:(CGFloat)vCenter
{
    CGRect frame = self.frame;
    frame.origin.y = vCenter - CGRectGetHeight(frame) / 2.0f;
    self.frame = frame;
}

- (void) setHCenter:(CGFloat)hCenter
{
    CGRect frame = self.frame;
    frame.origin.x = hCenter - CGRectGetWidth(frame) / 2.0f;
    self.frame = frame;
}

@end
