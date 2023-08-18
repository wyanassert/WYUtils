//
//  WYFlipClockItem.m
//  WYUtils
//
//  Created by wyan on 2023/8/18.
//

#import "WYFlipClockItem.h"
#import "WYFlipClockLabel.h"

@implementation WYFlipClockItemColors

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _textColor = [UIColor whiteColor];
        _labelBackgroudColor = [UIColor blackColor];
    }
    return self;
}

@end

@interface WYFlipClockItem ()

@property (nonatomic, strong) WYFlipClockLabel *leftLabel;
@property (nonatomic, strong) WYFlipClockLabel *rightLabel;

@property (nonatomic, assign) NSInteger lastLeftTime;
@property (nonatomic, assign) NSInteger lastRightTime;

@end

@implementation WYFlipClockItem

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

#pragma mark - Public

- (void)updateLabelThemeColor:(WYFlipClockItemColors *)colors
{
    self.leftLabel.currentBackgroundColor = colors.labelBackgroudColor;
    self.rightLabel.currentBackgroundColor = colors.labelBackgroudColor;
    self.leftLabel.currentTextColor = colors.textColor;
    self.rightLabel.currentTextColor = colors.textColor;
}

#pragma mark - Override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat labelW = self.bounds.size.width / 2;
    CGFloat labelH = self.bounds.size.height;
    self.leftLabel.frame = CGRectMake(0, 0, labelW, labelH);
    self.leftLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.frame = CGRectMake(labelW, 0, labelW, labelH);
    self.rightLabel.textAlignment = NSTextAlignmentLeft;
    self.layer.cornerRadius = self.bounds.size.height / 10;
    self.layer.masksToBounds = YES;
}

#pragma mark - Private

- (void)commonInitial
{
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    
    self.lastLeftTime = -1;
    self.lastRightTime = -1;
}

/// 配置左边的时间
/// - Parameter time: 时间
- (void)configLeftTimeLabel:(NSInteger)time
{
    if (self.lastLeftTime == time && self.lastLeftTime != -1)
    {
        return ;
    }
    self.lastLeftTime = time;
    NSInteger current = 0;
    switch (self.type)
    {
        case WYFlipClockItemTypeHour:
            current = time == 0 ? 2 : time - 1;
        case WYFlipClockItemTypeMinute:
            current = time == 0 ? 5 : time - 1;
        case WYFlipClockItemTypeSecond:
            current = time == 0 ? 5 : time - 1;
    }
    [self.leftLabel updateTime:current next:time];
}

- (void)configRightTimeLabel:(NSInteger)time
{
    if (self.lastRightTime == time && self.lastRightTime != -1)
    {
        return ;
    }
    self.lastRightTime = time;
    NSInteger current = 0;
    switch (self.type)
    {
        case WYFlipClockItemTypeHour:
            current = time == 0 ? 4 : time - 1;
        case WYFlipClockItemTypeMinute:
            current = time == 0 ? 9 : time - 1;
        case WYFlipClockItemTypeSecond:
            current = time == 0 ? 9 : time - 1;
    }
    [self.rightLabel updateTime:current next:time];
}

#pragma mark - Setter

- (void)setTime:(NSInteger)time
{
    _time = time;
    [self configLeftTimeLabel:time / 10];
    [self configRightTimeLabel:time % 10];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    self.leftLabel.font = font;
    self.rightLabel.font = font;
}

#pragma mark - Getter


- (WYFlipClockLabel *)rightLabel
{
    if (!_rightLabel)
    {
        _rightLabel = [[WYFlipClockLabel alloc] init];
    }
    return _rightLabel;
}

- (WYFlipClockLabel *)leftLabel
{
    if (!_leftLabel)
    {
        _leftLabel = [[WYFlipClockLabel alloc] init];
    }
    return _leftLabel;
}

@end
