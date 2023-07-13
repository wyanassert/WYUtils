//
//  UIView+GravityMotion.h
//  WYUtils
//
//  Created by wyan on 2023/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CMMotionManager;

@interface UIView (GravityMotion)

/// 设置 View 跟随陀螺仪水平移动
/// @param speed 移动速率, 默认 1
/// @param maxHorizontalOffset 横向移动最大值
/// @param maxVerticalOffset 纵向移动最大值
- (void)gm_startWithSpeed:(CGFloat)speed
      maxHorizontalOffset:(CGFloat)maxHorizontalOffset
        maxVerticalOffset:(CGFloat)maxVerticalOffset;

/// 停止跟随陀螺仪水平移动
- (void)gm_stop;

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, assign) float lastGravityX;
@property (nonatomic, assign) float lastGravityY;
@property (nonatomic, assign) CGPoint lastViewCenter;

@end

NS_ASSUME_NONNULL_END
