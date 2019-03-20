//
//  BTMaskView.m
//  BTMaskView
//
//  Created by Joyingx on 15/12/1.
//  Copyright © 2015年 Joyingx. All rights reserved.
//

#import "WYMaskView.h"

@interface WYMaskView ()

@property (nonatomic, weak) CAShapeLayer *fillLayer;
@property (nonatomic, strong) UIBezierPath *overlayPath;

@property (nonatomic, strong) NSMutableArray *transparentPaths;

@end

@implementation WYMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self refreshMask];
}

#pragma mark - Public Methods

- (void)reset {
    [self.transparentPaths removeAllObjects];
    
    [self refreshMask];
}

- (void)addTransparentPath:(UIBezierPath *)transparentPath {
    [self.overlayPath appendPath:transparentPath];
    
    [self.transparentPaths addObject:transparentPath];
    
    self.fillLayer.path = self.overlayPath.CGPath;
}

- (void)addTransparentRect:(CGRect)rect {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithRect:rect];

    [self addTransparentPath:transparentPath];
}

- (void)addTransparentRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    
    [self addTransparentPath:transparentPath];
}

- (void)addTransparentRoundedRect:(CGRect)rect
                byRoundingCorners:(UIRectCorner)corners
                      cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    
    [self addTransparentPath:transparentPath];
}

- (void)addTransparentOvalRect:(CGRect)rect {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    [self addTransparentPath:transparentPath];
}

#pragma mark - Private Methods

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    self.maskColor = [UIColor colorWithWhite:0 alpha:0.5]; // 50% transparent black
    
    self.fillLayer.path = self.overlayPath.CGPath;
    self.fillLayer.fillRule = kCAFillRuleEvenOdd;
    self.fillLayer.fillColor = self.maskColor.CGColor;
}

- (UIBezierPath *)generateOverlayPath {
    UIBezierPath *overlayPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [overlayPath setUsesEvenOddFillRule:YES];
    
    return overlayPath;
}

- (UIBezierPath *)currentOverlayPath {
    UIBezierPath *overlayPath = [self generateOverlayPath];
    
    for (UIBezierPath *transparentPath in self.transparentPaths) {
        [overlayPath appendPath:transparentPath];
    }
    
    return overlayPath;
}

- (void)refreshMask {
    self.overlayPath = [self currentOverlayPath];
    
    self.fillLayer.frame = self.bounds;
    self.fillLayer.path = self.overlayPath.CGPath;
    self.fillLayer.fillColor = self.maskColor.CGColor;
}

#pragma mark - Setter and Getter Methods

- (UIBezierPath *)overlayPath {
    if (!_overlayPath) {
        _overlayPath = [self generateOverlayPath];
    }
    
    return _overlayPath;
}

- (CAShapeLayer *)fillLayer {
    if (!_fillLayer) {
        CAShapeLayer *fillLayer = [CAShapeLayer layer];
        fillLayer.frame = self.bounds;
        [self.layer addSublayer:fillLayer];
        
        _fillLayer = fillLayer;
    }
    
    return _fillLayer;
}

- (NSMutableArray *)transparentPaths {
    if (!_transparentPaths) {
        _transparentPaths = [NSMutableArray array];
    }
    
    return _transparentPaths;
}

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    
    [self refreshMask];
}

@end
