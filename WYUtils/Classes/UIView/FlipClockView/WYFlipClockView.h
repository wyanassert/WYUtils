//
//  WYFlipClockView.h
//  WYUtils
//
//  Created by wyan on 2023/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYFlipClockView : UIView

@property (nonatomic, strong) NSDate *date;

/// 是否为十二小时制  (默认：24小时制。FALSE,)
@property (nonatomic, assign) BOOL is12HourClock;

@property (nonatomic, strong) UIColor *currTextColor;
@property (nonatomic, strong) UIColor *currBackgroudColor;
@property (nonatomic, strong) UIFont *currFont;

@end

NS_ASSUME_NONNULL_END
