//
//  WYNotHintView.m
//  InscardNew
//
//  Created by wyan on 2019/3/20.
//  Copyright © 2019 makeupopular.com. All rights reserved.
//

#import "WYNotHintView.h"

@implementation WYNotHintView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    if ([self pointInside:point withEvent:event]) {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
        return nil;
    }
    return nil;
}

@end
