//
//  WYFlipClockItem.h
//  WYUtils
//
//  Created by wyan on 2023/8/18.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WYFlipClockItemType)
{
    WYFlipClockItemTypeHour = 0,
    WYFlipClockItemTypeMinute = 1,
    WYFlipClockItemTypeSecond = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface WYFlipClockItemColors : NSObject

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *labelBackgroudColor;

@end

@interface WYFlipClockItem : UIView

@property (nonatomic, assign) WYFlipClockItemType type;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, strong) UIFont *font;

/// 更新Label的主题颜色
/// - Parameter colors: 当前颜色
- (void)updateLabelThemeColor:(WYFlipClockItemColors *)colors;

@end

NS_ASSUME_NONNULL_END
