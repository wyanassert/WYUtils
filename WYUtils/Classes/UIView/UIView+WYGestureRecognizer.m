//
//  UIView+WYGestureRecognizer.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/11/26.
//

#import "UIView+WYGestureRecognizer.h"

@implementation UIView (WYGestureRecognizer)

- (void)wy_addPanAction {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wy_panAction:)];
    [self addGestureRecognizer:pan];
}

- (void)wy_addPinchAction {
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(wy_pinchAction:)];
    [self addGestureRecognizer:pinch];
}

- (void)wy_addRotateAction {
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(wy_rotateAction:)];
    [self addGestureRecognizer:rotate];
}

#pragma mark - Action
- (void)wy_panAction:(UIPanGestureRecognizer *)pan {
    UIGestureRecognizerState state = [pan state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan translationInView:pan.view];
        [pan.view setTransform:CGAffineTransformTranslate(pan.view.transform, translation.x, translation.y)];
        [pan setTranslation:CGPointZero inView:pan.view];
    }
}

- (void)wy_pinchAction:(UIPinchGestureRecognizer *)pinch {
    
    UIGestureRecognizerState state = [pinch state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        CGFloat scale = [pinch scale];
        [pinch.view setTransform:CGAffineTransformScale(pinch.view.transform, scale, scale)];
        [pinch setScale:1.0];
    }
}

- (void)wy_rotateAction:(UIRotationGestureRecognizer *)rotate {
    UIGestureRecognizerState state = [rotate state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        CGFloat rotation = [rotate rotation];
        [rotate.view setTransform:CGAffineTransformRotate(rotate.view.transform, rotation)];
        [rotate setRotation:0];
    }
}

@end
