//
//  WYBorderLabel.m
//  FrameFour
//
//  Created by wyan on 2019/6/21.
//  Copyright © 2019 makeupopular.com. All rights reserved.
//

#import "WYBorderLabel.h"

@interface WYBorderLabel ()

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;

@end

@implementation WYBorderLabel

- (instancetype)initWithBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor
{
    if (self = [super init]) {
        self.borderWidth = borderWidth;
        self.borderColor = borderColor;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, self.borderWidth);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = self.borderColor;
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
}

@end
