//
//  WYFlipClockLabel.m
//  WYUtils
//
//  Created by wyan on 2023/8/18.
//

#import "WYFlipClockLabel.h"

/// 下一个label开始值
static CGFloat const kNextLabelStartValue = 0.01;

@interface WYFlipClockLabel ()

/// 动画执行进度
@property (nonatomic, assign) CGFloat animateValue;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *foldLabel;
@property (nonatomic, strong) UILabel *nextLabel;
@property (nonatomic, strong) UIView *labelContainer;
@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation WYFlipClockLabel

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

- (void)updateTime:(NSInteger)time next:(NSInteger)next
{
    BOOL animated = self.timeLabel.text.length > 0;
    if (animated)
    {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld", time];
        self.foldLabel.text = [NSString stringWithFormat:@"%ld", time];
        self.nextLabel.text = [NSString stringWithFormat:@"%ld", next];
        self.nextLabel.layer.transform = [self nextLabelStartTransform];
        self.nextLabel.hidden = YES;
        self.animateValue = 0.0;
        [self start];
    }
    else // 第一次
    {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld", next];
        self.foldLabel.text = [NSString stringWithFormat:@"%ld", next];
        self.nextLabel.text = [NSString stringWithFormat:@"%ld", next];
    }
}

#pragma mark - Override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.labelContainer.frame = self.bounds;
    self.timeLabel.frame = self.labelContainer.bounds;
    self.nextLabel.frame = self.labelContainer.bounds;
    self.foldLabel.frame = self.labelContainer.bounds;
}

#pragma mark - Private

- (void)commonInitial
{
    [self addSubview:self.labelContainer];
    [self.labelContainer addSubview:self.timeLabel];
    [self.labelContainer addSubview:self.nextLabel];
    [self.labelContainer addSubview:self.foldLabel];
}

#pragma mark - Animations

/// 下一个label开始动画 默认label起始角度
///
/// - Returns: CATransform3D
- (CATransform3D)nextLabelStartTransform
{
    CATransform3D t = CATransform3DIdentity;
    t.m34 = CGFLOAT_MIN;
    t = CATransform3DRotate(t, M_PI * kNextLabelStartValue, -1, 0, 0);
    return t;
}

#pragma mark - Timer

- (void)updateAnimateLabel
{
    self.animateValue += 2 / 60.0;
    if (self.animateValue >= 1)
    {
        [self stop];
        return ;
    }
    CATransform3D t = CATransform3DIdentity;
    t.m34 = CGFLOAT_MIN;
    
    // 绕x轴进行翻转
    t = CATransform3DRotate(t, M_PI * self.animateValue, -1, 0, 0);
    if (self.animateValue >= 0.5)
    {
        // 当翻转到和屏幕垂直时，翻转y和z轴
        t = CATransform3DRotate(t, M_PI, 0, 0, 1);
        t = CATransform3DRotate(t, M_PI, 0, 1, 0);
    }
    self.foldLabel.layer.transform = t;
    
    // 当翻转到和屏幕垂直时，切换动画label的字
    self.foldLabel.text = self.animateValue >= 0.5 ? self.nextLabel.text : self.timeLabel.text;
    
    // 当翻转到指定角度时，显示下一秒的时间
    self.nextLabel.hidden = self.animateValue <= kNextLabelStartValue;
}

/// 开始动画
- (void)start
{
    [self.link addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
}

/// 停止动画
- (void)stop
{
    [self.link removeFromRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
}

#pragma mark - Setter

- (void)setFont:(UIFont *)font
{
    _font = font;
    self.timeLabel.font = font;
    self.foldLabel.font = font;
    self.nextLabel.font = font;
}

- (void)setCurrentTextColor:(UIColor *)currentTextColor
{
    _currentTextColor = currentTextColor;
    self.timeLabel.textColor = currentTextColor;
    self.foldLabel.textColor = currentTextColor;
    self.nextLabel.textColor = currentTextColor;
}

- (void)setCurrentBackgroundColor:(UIColor *)currentBackgroundColor
{
    _currentBackgroundColor = currentBackgroundColor;
    self.timeLabel.backgroundColor = currentBackgroundColor;
    self.foldLabel.backgroundColor = currentBackgroundColor;
    self.nextLabel.backgroundColor = currentBackgroundColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    self.timeLabel.textAlignment = textAlignment;
    self.foldLabel.textAlignment = textAlignment;
    self.nextLabel.textAlignment = textAlignment;
}

#pragma mark - Getter

- (UILabel *)nextLabel
{
    if (!_nextLabel)
    {
        UILabel *lb = [UILabel new];
        lb.layer.masksToBounds = YES;
        lb.textColor = UIColor.whiteColor;
        lb.backgroundColor = UIColor.blackColor;
        _nextLabel = lb;
    }
    return _nextLabel;
}

- (UILabel *)foldLabel
{
    if (!_foldLabel)
    {
        UILabel *lb = [UILabel new];
        lb.layer.masksToBounds = YES;
        lb.textColor = UIColor.whiteColor;
        lb.backgroundColor = UIColor.blackColor;
        _foldLabel = lb;
    }
    return _foldLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        UILabel *lb = [UILabel new];
        lb.layer.masksToBounds = YES;
        lb.textColor = UIColor.whiteColor;
        lb.backgroundColor = UIColor.blackColor;
        _timeLabel = lb;
    }
    return _timeLabel;
}

- (UIView *)labelContainer
{
    if (!_labelContainer)
    {
        _labelContainer = [[UIView alloc] init];
    }
    return _labelContainer;
}

- (CADisplayLink *)link
{
    if (!_link)
    {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAnimateLabel)];
    }
    return _link;
}

@end
