//
//  WYWaveView.h
//  Masonry
//
//  Created by wyan on 2020/6/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYWaveView : UIView

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame;

/*
 waveNum: //容纳完整波浪个数waveCount, default:1
 waveSpeed: //波浪速度speed, default:0.05
 firstWaveTime: //起始位置 startPoint, default:0, range:0~1
 */

- (instancetype)initWithFrame:(CGRect)frame waveNum:(CGFloat)waveNum waveSpeed:(CGFloat)waveSpeed firstWaveTime:(CGFloat)firstWaveTime;

- (void)startWave;
- (void)stopWave;

@property (nonatomic, assign) CGFloat         waveCenterHeight;//波中心高度, default:Height-waveAmplitude
@property (nonatomic, assign) CGFloat         waveAmplitude; //振幅Amplitude, default:30
@property (nonatomic, strong) NSArray         *colors;

@end

NS_ASSUME_NONNULL_END
