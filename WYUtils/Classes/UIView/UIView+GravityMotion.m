//
//  UIView+GravityMotion.m
//  WYUtils
//
//  Created by wyan on 2023/7/13.
//

#import "UIView+GravityMotion.h"
#import <CoreMotion/CoreMotion.h>
#import <objc/runtime.h>

static CGFloat const kGravityMotionUpdateInterval = 1.0 / 60;
static NSString *const kGravityMotionPositionAnimation = @"kGravityMotionPositionAnimation";

@implementation UIView (GravityMotion)

- (void)gm_startWithSpeed:(CGFloat)speed
      maxHorizontalOffset:(CGFloat)maxHorizontalOffset
        maxVerticalOffset:(CGFloat)maxVerticalOffset
{
    if (!self.motionManager)
    {
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = kGravityMotionUpdateInterval;
        __weak typeof(self)weakSelf = self;
        [self.motionManager startDeviceMotionUpdatesToQueue:NSOperationQueue.mainQueue
                                                withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            __strong typeof(weakSelf)self = weakSelf;
            if (!error && motion)
            {
                [self gm_updateWithGravityX:motion.gravity.x
                                   gravityY:motion.gravity.y
                                      speed:speed
                        maxHorizontalOffset:maxHorizontalOffset
                          maxVerticalOffset:maxVerticalOffset];
            }
        }];
    }
    self.lastViewCenter = self.center;
}

- (void)gm_stop
{
    [self.motionManager stopDeviceMotionUpdates];
}

#pragma mark - Private

- (void)gm_updateWithGravityX:(float)gravityX
                     gravityY:(float)gravityY
                        speed:(CGFloat)speed
          maxHorizontalOffset:(CGFloat)maxHorizontalOffset
            maxVerticalOffset:(CGFloat)maxVerticalOffset
{
    
    float timeInterval = sqrt(pow((gravityX - self.lastGravityX), 2) + pow((gravityY - self.lastGravityY), 2)) * kGravityMotionUpdateInterval * speed;
    
    CGPoint newLastViewCenter = CGPointMake(self.center.x + gravityX * maxHorizontalOffset,
                                                 self.center.y + gravityY * maxVerticalOffset);
    
    CABasicAnimation *backImageViewAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    backImageViewAnimation.fromValue = [NSValue valueWithCGPoint:self.lastViewCenter];
    backImageViewAnimation.toValue = [NSValue valueWithCGPoint:newLastViewCenter];
    backImageViewAnimation.duration = timeInterval;
    backImageViewAnimation.fillMode = kCAFillModeForwards;
    backImageViewAnimation.removedOnCompletion = NO;
    
    
    [self.layer removeAnimationForKey:kGravityMotionPositionAnimation];
    [self.layer addAnimation:backImageViewAnimation forKey:kGravityMotionPositionAnimation];
    
    self.lastViewCenter = newLastViewCenter;
    
}

#pragma mark - Getter & Setter

- (void)setMotionManager:(CMMotionManager *)motionManager
{
    objc_setAssociatedObject(self, @selector(motionManager), motionManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CMMotionManager *)motionManager
{
    return objc_getAssociatedObject(self, @selector(motionManager));
}

- (void)setLastGravityX:(float)lastGravityX
{
    objc_setAssociatedObject(self, @selector(lastGravityX), @(lastGravityX), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)lastGravityX
{
    return [objc_getAssociatedObject(self, @selector(lastGravityX)) floatValue];
}

- (void)setLastGravityY:(float)lastGravityY
{
    objc_setAssociatedObject(self, @selector(lastGravityY), @(lastGravityY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)lastGravityY
{
    return [objc_getAssociatedObject(self, @selector(lastGravityY)) floatValue];
}

- (void)setLastViewCenter:(CGPoint)lastViewCenter
{
    objc_setAssociatedObject(self, @selector(lastViewCenter), [NSValue valueWithCGPoint:lastViewCenter], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)lastViewCenter
{
    return [objc_getAssociatedObject(self, @selector(lastViewCenter)) CGPointValue];
}


@end
