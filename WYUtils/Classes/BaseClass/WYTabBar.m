//
//  WYTabBar.m
//  WanYan
//
//  Created by 李袁野 on 2018/7/24.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import "WYTabBar.h"

@implementation WYTabBar

#pragma mark - Life Cycle

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self bringSubviewToFront:self.base_plusButton];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    if (width <= 0.f || height <= 0.f) {
        return;
    }
    
    if (self.items.count > 0) {
        
        NSInteger index = 0;
        NSInteger itemCount = MIN(5, self.items.count);
        NSInteger midCount = itemCount / 2 + (itemCount % 2 > 0 ? 1 : 0);
        CGFloat tabBarButtonW = self.frame.size.width / (float)(itemCount + 1);
        
        for (UIView *subview in self.subviews) {
            
            if (![NSStringFromClass(subview.class) isEqualToString:@"UITabBarButton"]) {
                continue;
            }
            
            CGFloat tabBarButtonX = (float)index * tabBarButtonW;
            if (index >= midCount) {
                tabBarButtonX += tabBarButtonW;
            }
            subview.frame = CGRectMake(tabBarButtonX, subview.frame.origin.y, tabBarButtonW, subview.frame.size.height);
            index++;
            if (index >= itemCount) {
                break;
            }
        }
    }
}

#pragma mark - Override

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden) {
        return [super hitTest:point withEvent:event];
    }
    CGPoint newPoint = [self convertPoint:point toView:self.base_plusButton];
    if ([self.base_plusButton pointInside:newPoint withEvent:event]) {
        return self.base_plusButton;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

#pragma mark - Public Methods

- (void)base_configPlusButton {
    
    if (self.base_plusButton.superview) {
        return;
    }
    [self addSubview:self.base_plusButton];
    if (self.base_configPlusButtonBlock) {
        self.base_configPlusButtonBlock(self.base_plusButton, self);
    }
}

#pragma mark - Action Methods

- (void)base_plusButtonAction:(UIButton *)plusButton {
    
    if (self.base_clickPlusButtonBlock) {
        self.base_clickPlusButtonBlock(plusButton);
    }
}

#pragma mark - Getters

- (UIButton *)base_plusButton {
    
    if (!_base_plusButton) {
        
        _base_plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _base_plusButton.translatesAutoresizingMaskIntoConstraints = YES;
        [_base_plusButton addTarget:self action:@selector(base_plusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _base_plusButton;
}

@end
