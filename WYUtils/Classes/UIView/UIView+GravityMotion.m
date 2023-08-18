//
//  UIView+GravityMotion.m
//  WYUtils
//
//  Created by wyan on 2023/7/13.
//


#import "UIView+GravityMotion.h"
#import <CoreMotion/CoreMotion.h>
#import <objc/runtime.h>

static CGFloat const kGravityMotionUpdateInterval = 1.0 / 60; // 30 帧有点卡
static NSString *const kGravityMotionPositionAnimation = @"kGravityMotionPositionAnimation";

@implementation UIView (GravityMotion)

- (void)gm_startWithMaxHorizontalOffset:(CGFloat)maxHorizontalOffset
                      maxVerticalOffset:(CGFloat)maxVerticalOffset
                             maxAngleDx:(CGFloat)maxAngleDx
                             maxAngleDy:(CGFloat)maxAngleDy
{
    if (!self.motionManager)
    {
        self.initialGravityX = nil;
        self.initialGravityY = nil;
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = kGravityMotionUpdateInterval;
        __weak typeof(self)weakSelf = self;
        [self.motionManager startDeviceMotionUpdatesToQueue:NSOperationQueue.mainQueue
                                                withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            __strong typeof(weakSelf)self = weakSelf;
            if (!error && motion)
            {
                CGFloat x = motion.gravity.x; // 取值 -1 -> 1
                CGFloat y = motion.gravity.y; // 取值 -1 -> 1
//                NSLog(@"UIView+GravityMotion-1 %.2f, %.2f", x, y);
                x = MAX(-1, MIN(1, x));
                y = MAX(-1, MIN(1, y));
                
                if (self.initialGravityX == nil) // 记录初始状态
                {
                    self.initialGravityX = @(x);
                }
                if (self.initialGravityY == nil)
                {
                    self.initialGravityY = @(y);
                }
                x -= self.initialGravityX.floatValue;
                y -= self.initialGravityY.floatValue;
                x = MAX(-1, MIN(1, x)); // 补偿值 超过上下限也不管了, 安卓也没管
                y = MAX(-1, MIN(1, y));
//                NSLog(@"UIView+GravityMotion-2 %.2f, %.2f", x, y);
                CGFloat maxX = MAX(0, MIN(1, maxAngleDx / 180));
                if (maxX > 0)
                {
                    x = MAX(-1.f, MIN(1.f, x / maxX));
                }

                CGFloat maxY = MAX(0, MIN(1, maxAngleDy / 180));
                if (maxY > 0)
                {
                    y = MAX(-1.f, MIN(1.f, y / maxY));
                }
                
                [self gm_updateWithGravityX:x
                                   gravityY:y
                        maxHorizontalOffset:maxHorizontalOffset
                          maxVerticalOffset:maxVerticalOffset];
            }
        }];
    }
}

- (void)gm_startRotateWithXAngel:(CGFloat)xAngel
                          yAngel:(CGFloat)yAngel
                       maxXAngel:(CGFloat)maxXAngel
                       maxYAngel:(CGFloat)maxYAngel
{
    if (!self.motionManager)
    {
        self.initialGravityX = nil;
        self.initialGravityY = nil;
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = kGravityMotionUpdateInterval;
        __weak typeof(self)weakSelf = self;
        [self.motionManager startDeviceMotionUpdatesToQueue:NSOperationQueue.mainQueue
                                                withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            __strong typeof(weakSelf)self = weakSelf;
            if (!error && motion)
            {
                CGFloat x = motion.gravity.x; // 取值 -1 -> 1
                CGFloat y = motion.gravity.y; // 取值 -1 -> 1
//                NSLog(@"UIView+GravityMotion-1 %.2f, %.2f", x, y);
                x = MAX(-1, MIN(1, x));
                y = MAX(-1, MIN(1, y));
                
                if (self.initialGravityX == nil) // 记录初始状态
                {
                    self.initialGravityX = @(x);
                }
                if (self.initialGravityY == nil)
                {
                    self.initialGravityY = @(y);
                }
                x -= self.initialGravityX.floatValue;
                y -= self.initialGravityY.floatValue;
                x = MAX(-1, MIN(1, x)); // 补偿值 超过上下限也不管了, 安卓也没管
                y = MAX(-1, MIN(1, y));
//                NSLog(@"UIView+GravityMotion-2 %.2f, %.2f", x, y);
                CGFloat maxX = MAX(0, MIN(1, maxXAngel / 90));
                CGFloat minX = MAX(0, MIN(1, 5 / 90)); // 默认 5 度才开始动
                if (maxX > 0 && minX >= 0 && maxX > minX)
                {
                    if (fabs(x) <= minX)
                    {
                        x = 0;
                    }
                    else if (fabs(x) >= maxX)
                    {
                        if (x > 0)
                        {
                            x = maxX;
                        }
                        else
                        {
                            x = - maxX;
                        }
                    }
                    else if (x > 0)
                    {
                        x = (fabs(x) - minX) / (maxX - minX) * maxX;
                    }
                    else
                    {
                        x = - (fabs(x) - minX) / (maxX - minX) * maxX;;
                    }
                }

                CGFloat maxY = MAX(0, MIN(1, maxYAngel / 90));
                CGFloat minY = MAX(0, MIN(1, 5 / 90)); // 5度开始动
                if (maxY > 0 && minY >= 0 && maxY > minY)
                {
                    if (fabs(y) <= minY)
                    {
                        y = 0;
                    }
                    else if (fabs(y) >= maxY)
                    {
                        if (y > 0)
                        {
                            y = maxY;
                        }
                        else
                        {
                            y = - maxY;
                        }
                    }
                    else if (y > 0)
                    {
                        y = (fabs(y) - minY) / (maxY - minY) * maxY;
                    }
                    else
                    {
                        y = - (fabs(y) - minY) / (maxY - minY) * maxY;;
                    }
                }
                if (xAngel > 0)
                {
                    x *= xAngel / maxXAngel;
                }
                if (yAngel > 0)
                {
                    y *= yAngel / maxYAngel;
                }
                [self gm_rotateWithGravityX:x gravityY:y];
            }
        }];
    }
}

- (void)gm_stop
{
    [self.motionManager stopDeviceMotionUpdates];
    self.motionManager = nil;
}

#pragma mark - Private
// gravityX 取值-1->1
// gravityY 取值-1->1
- (void)gm_updateWithGravityX:(float)gravityX
                     gravityY:(float)gravityY
          maxHorizontalOffset:(CGFloat)maxHorizontalOffset
            maxVerticalOffset:(CGFloat)maxVerticalOffset
{
    CGFloat transformX = (gravityX - self.lastGravityX) * maxHorizontalOffset;
    CGFloat transformY = (gravityY - self.lastGravityY) * maxVerticalOffset;
    self.transform = CGAffineTransformTranslate(self.transform, transformX, transformY);
    self.lastGravityX = gravityX;
    self.lastGravityY = gravityY;
}

// gravityX 取值-1->1
// gravityY 取值-1->1
- (void)gm_rotateWithGravityX:(float)gravityX
                     gravityY:(float)gravityY
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 500.0; // 景深, 估计值, 500~3000 都可以, 按情况调一下
    transform = CATransform3DRotate(transform, gravityX * M_PI_2, 0, 1, 0);
    transform = CATransform3DRotate(transform, gravityY * M_PI_2, 1, 0, 0);
    self.layer.transform = transform;
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

- (void)setInitialGravityX:(NSNumber *)initialGravityX
{
    objc_setAssociatedObject(self, @selector(initialGravityX), initialGravityX, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)initialGravityX
{
    return objc_getAssociatedObject(self, @selector(initialGravityX));
}

- (void)setInitialGravityY:(NSNumber *)initialGravityY
{
    objc_setAssociatedObject(self, @selector(initialGravityY), initialGravityY, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)initialGravityY
{
    return objc_getAssociatedObject(self, @selector(initialGravityY));
}


@end

