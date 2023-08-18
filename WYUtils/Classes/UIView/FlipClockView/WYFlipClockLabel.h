//
//  WYFlipClockLabel.h
//  WYUtils
//
//  Created by wyan on 2023/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYFlipClockLabel : UIView

@property (nonatomic, strong) UIFont *font;
/// 当前文字颜色
@property (nonatomic, strong) UIColor *currentTextColor;
/// 当前背景色
@property (nonatomic, strong) UIColor *currentBackgroundColor;
/// 文字对齐方式 （默认，居左对齐）
@property (nonatomic, assign) NSTextAlignment textAlignment;

/// 更新时间
///
/// - Parameters:
///   - time: 时间
///   - nextTime: 下一个时间
- (void)updateTime:(NSInteger)time next:(NSInteger)next;

@end

NS_ASSUME_NONNULL_END
