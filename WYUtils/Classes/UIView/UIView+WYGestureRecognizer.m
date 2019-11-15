//
//  UIView+WYGestureRecognizer.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/11/26.
//

#import "UIView+WYGestureRecognizer.h"
#import <objc/runtime.h>

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;

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

- (void)wy_addTapActionWithBlock:(TapActionBlock)block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wy_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)wy_addLongPressActionWithBlock:(LongPressActionBlock)block {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(wy_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
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

- (void)wy_handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        TapActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)wy_handleActionForLongPressGesture:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        LongPressActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

@end
