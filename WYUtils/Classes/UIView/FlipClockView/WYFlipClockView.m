//
//  WYFlipClockView.m
//  WYUtils
//
//  Created by wyan on 2023/8/18.
//

#import "WYFlipClockView.h"
#import "WYFlipClockItem.h"

@interface WYFlipClockView ()

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateComponents *dateComponent;
@property (nonatomic, strong) WYFlipClockItem *hourItem;
@property (nonatomic, strong) WYFlipClockItem *minuteItem;
@property (nonatomic, strong) WYFlipClockItem *secondItem;

@property (nonatomic, strong) WYFlipClockItemColors *colors;

@end

@implementation WYFlipClockView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commonInitial];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInitial];
    }
    return self;
}

#pragma mark - Private

- (void)commonInitial
{
    [self addSubview:self.hourItem];
    [self addSubview:self.minuteItem];
    [self addSubview:self.secondItem];
}

#pragma mark - Override

- (void)layoutSubviews
{
    [super layoutSubviews];
    /// 间距
    CGFloat margin = 0.07 * self.bounds.size.width;
    /// 每个item的宽度
    CGFloat itemW = (self.bounds.size.width - 4 * margin) / 3;
    /// 每个item的Y值
    CGFloat itemY = (self.bounds.size.height - itemW) / 2;
    
    self.hourItem.frame = CGRectMake(margin, itemY, itemW, itemW);
    self.minuteItem.frame = CGRectMake(CGRectGetMaxX(self.hourItem.frame) + margin, itemY, itemW, itemW);
    self.secondItem.frame = CGRectMake(CGRectGetMaxX(self.minuteItem.frame) + margin, itemY, itemW, itemW);
}

- (void)updateColors
{
    self.colors.textColor = self.currTextColor ?: self.colors.textColor;
    self.colors.labelBackgroudColor = self.currBackgroudColor ?: self.colors.labelBackgroudColor;
    
    [self.hourItem updateLabelThemeColor:self.colors];
    [self.minuteItem updateLabelThemeColor:self.colors];
    [self.secondItem updateLabelThemeColor:self.colors];
}

#pragma mark - Setter

- (void)setDate:(NSDate *)date
{
    _date = date;
    self.calendar.locale = [NSLocale autoupdatingCurrentLocale];
    self.dateComponent = [NSCalendar.currentCalendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                                       fromDate:_date];
    // 如果为十二小时制，且当前时间大于12小时，转换当前时间24小时制到12小时制
    if (self.is12HourClock && self.dateComponent.hour > 12)
    {
        self.dateComponent.hour -= 12;
    }
    self.hourItem.time = self.dateComponent.hour;
    self.minuteItem.time = self.dateComponent.minute;
    self.secondItem.time = self.dateComponent.second;
}

- (void)setCurrTextColor:(UIColor *)currTextColor
{
    _currTextColor = currTextColor;
    [self updateColors];
}

- (void)setCurrBackgroudColor:(UIColor *)currBackgroudColor
{
    _currBackgroudColor = currBackgroudColor;
    [self updateColors];
}

- (void)setCurrFont:(UIFont *)currFont
{
    _currFont = currFont;
    
    self.hourItem.font = currFont;
    self.minuteItem.font = currFont;
    self.secondItem.font = currFont;
}

#pragma mark - Getter

- (NSCalendar *)calendar
{
    if (!_calendar)
    {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}


- (WYFlipClockItem *)secondItem
{
    if (!_secondItem)
    {
        _secondItem = [[WYFlipClockItem alloc] init];
        _secondItem.type = WYFlipClockItemTypeSecond;
    }
    return _secondItem;
}

- (WYFlipClockItem *)minuteItem
{
    if (!_minuteItem)
    {
        _minuteItem = [[WYFlipClockItem alloc] init];
        _minuteItem.type = WYFlipClockItemTypeMinute;
    }
    return _minuteItem;
}

- (WYFlipClockItem *)hourItem
{
    if (!_hourItem)
    {
        _hourItem = [[WYFlipClockItem alloc] init];
        _hourItem.type = WYFlipClockItemTypeHour;
    }
    return _hourItem;
}

- (WYFlipClockItemColors *)colors
{
    if (!_colors)
    {
        _colors = [[WYFlipClockItemColors alloc] init];
    }
    return _colors;
}
@end
