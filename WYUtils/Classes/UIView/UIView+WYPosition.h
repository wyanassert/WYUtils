//
//  UIView+WYPosition.h
//  WYUtils
//
//  Created by wyan on 2024/6/17.
//
//  简易访问／设置UIView的frame及其成员


#import <UIKit/UIKit.h>

@interface UIView (WYPosition)

- (CGFloat)getTop;
- (CGFloat)getLeft;
- (CGFloat)getRight;
- (CGFloat)getBottom;
- (CGFloat)getWidth;
- (CGFloat)getHeight;
- (void)setTop:(CGFloat)top;
- (void)setTopIfNeeded:(CGFloat)top;
- (void)setBottom:(CGFloat)bottom;
- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;
- (void)setLeftTop:(CGPoint)leftTop;
- (CGPoint)origin;
- (void)setOrigin:(CGPoint) point;

- (CGSize)size;
- (void)setSize:(CGSize) size;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

// 设置左上角
- (void)setX:(CGFloat)x Y:(CGFloat)y;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

// 中心点
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (CGFloat)centerX;
- (CGFloat)centerY;

// 横向设置，同时设定x和宽度
- (void) setLeft:(CGFloat)left width:(CGFloat)width;

// 垂直设置，同时设定y和高度
- (void) setTop:(CGFloat)top height:(CGFloat)height;

// 同时设定宽和高
- (void)setWidth:(CGFloat)width height:(CGFloat)height;

// 设置垂直方向的中心点
- (void) setVCenter:(CGFloat)vCenter;

// 设置水平方向的中心点
- (void) setHCenter:(CGFloat)hCenter;

@end
