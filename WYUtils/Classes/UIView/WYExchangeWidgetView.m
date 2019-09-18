//
//  WYExchangeWidgetView.m
//  ShakeCollage
//
//  Created by wyan on 2019/9/17.
//  Copyright © 2019 makeupopular.com. All rights reserved.
//

#import "WYExchangeWidgetView.h"

@interface WYExchangeWidgetView () {
    BOOL contain;
    CGPoint startPoint;
    CGPoint originPoint;
    CGRect originFrame;
}

@property (nonatomic, strong) NSMutableArray <UIView *> *itemsList;
@property (nonatomic, strong) UIView *tempView;

@end

@implementation WYExchangeWidgetView

- (void)addWidgetsForExchange:(NSArray<UIView *> *)widgetList {
    _itemsList = [NSMutableArray arrayWithArray:widgetList];
    for (UIView *displayView in widgetList) {
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [displayView addGestureRecognizer:longGesture];
    }
}

- (void)didExchangeView1:(UIView *)view1 andView2:(UIView *)view2 {
    
}

- (void)didEndLongPress {
    
}

#pragma mark - Action
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender {
    UIView *btn = (UIView *)sender.view;
    if (sender.state == UIGestureRecognizerStateBegan) {
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
        originFrame = btn.frame;
        [self bringSubviewToFront:btn];
        [UIView animateWithDuration:.2 animations:^{
            
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        btn.center = CGPointMake(btn.center.x+deltaX,btn.center.y+deltaY);
        CGPoint judgePoint = CGPointMake(btn.frame.origin.x + newPoint.x, btn.frame.origin.y + newPoint.y);
        NSInteger index = [self indexOfPoint:judgePoint withButton:btn];
        
        if (index < 0) {
            contain = NO;
            _tempView = nil;
        } else {
            contain = YES;
            _tempView = _itemsList[index];
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            if (!self->contain && !self->_tempView)
            {
                btn.center = self->originPoint;
            } else {
                btn.frame = self->_tempView.frame;
                self->_tempView.frame = self->originFrame;
                [self didExchangeView1:btn andView2:self->_tempView];
            }
        } completion:^(BOOL finished) {
            self->_tempView = nil;
            self->contain = NO;
            [self didEndLongPress];
        }];
    }
}

- (NSInteger)indexOfPoint:(CGPoint)point withButton:(UIView *)btn {
    for (NSInteger i = 0; i < _itemsList.count; i++) {
        UIView *button = _itemsList[i];
        if (button != btn) {
            if (CGRectContainsPoint(button.frame, point)) {
                return i;
            }
        }
    }
    return -1;
}


@end
