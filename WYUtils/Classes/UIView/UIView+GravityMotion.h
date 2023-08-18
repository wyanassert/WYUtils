//
//  UIView+GravityMotion.h
//  WYUtils
//
//  Created by wyan on 2023/7/13.
//

#import <UIKit/UIKit.h>


@class CMMotionManager;

@interface UIView (GravityMotion)

/// 设置 View 跟随陀螺仪水平移动
/// @param maxHorizontalOffset 横向移动最大值(单向)
/// @param maxVerticalOffset 纵向移动最大值(单向)
/// @param maxAngleDx 横向(左右)旋转角度, 90 表示 左右各 45 度
/// @param maxAngleDy 纵向(上下)旋转角度, 90 上下各 40 度
- (void)gm_startWithMaxHorizontalOffset:(CGFloat)maxHorizontalOffset
                      maxVerticalOffset:(CGFloat)maxVerticalOffset
                             maxAngleDx:(CGFloat)maxAngleDx
                             maxAngleDy:(CGFloat)maxAngleDy;


/// 设置 View 跟随陀螺仪 z 轴方向动画
/// @param xAngel 动画 x 轴最大倾角
/// @param yAngel 动画 y 轴最大倾角
/// @param maxXAngel 到 maxXAngel 停止做z 轴方向动画, 30 表示 左右各 30 度动画达到最大幅度
/// @param maxYAngel 到 maxYAngel 停止做z 轴方向动画, 30 表示 上下各 30 度动画达到最大幅度
- (void)gm_startRotateWithXAngel:(CGFloat)xAngel
                          yAngel:(CGFloat)yAngel
                       maxXAngel:(CGFloat)maxXAngel
                       maxYAngel:(CGFloat)maxYAngel;

/// 停止跟随陀螺仪水平移动
- (void)gm_stop;

/// 重置进入的位置
- (void)gm_resetInitialStatus;

@property (nonatomic, strong, nullable) CMMotionManager *motionManager;

@property (nonatomic, assign) float lastGravityX;
@property (nonatomic, assign) float lastGravityY;

// 产品设计觉得进来时候处于中间更好, 所以记录下初始化时候的偏移值
@property (nonatomic, strong, nullable) NSNumber *initialGravityX;
@property (nonatomic, strong, nullable) NSNumber *initialGravityY;

@end
