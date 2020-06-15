//
//  WYWaveView.m
//  Masonry
//
//  Created by wyan on 2020/6/15.
//

#import "WYWaveView.h"
#import "WYMacroHeader.h"
#import "WYWeakProxy.h"

@interface WYWaveView ()

@property (nonatomic, assign, readwrite) CGFloat         waveNum;
@property (nonatomic, assign, readwrite) CGFloat         waveSpeed;
@property (nonatomic, assign, readwrite) int             firstWaveTime;
@property (nonatomic, strong, readwrite) CAGradientLayer *gradientLayer;

@property (strong, nonatomic) CAShapeLayer *firstWaveLayer;
@property (assign, nonatomic) CGFloat firstWaveCircle;//单位像素周期(由WaveNum计算得出)
@property (assign, nonatomic) int firstCircleTime;
@property (assign, nonatomic) float firstVariable;     //可变参数 更加真实 模拟波纹
@property (assign, nonatomic) BOOL firstIncrease;      // 增减变化

@property (strong, nonatomic) CADisplayLink *firstWaveDisplayLink;

@end

@implementation WYWaveView

- (instancetype)initWithFrame:(CGRect)frame waveNum:(CGFloat)waveNum waveSpeed:(CGFloat)waveSpeed firstWaveTime:(CGFloat)firstWaveTime {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _waveAmplitude = 30;
        _waveCenterHeight = WYHEIGHT(self) - _waveAmplitude;
        _waveNum = waveNum;
        _waveSpeed = waveSpeed;
        
        _colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:122.0f/255.0f green:95.0f/255.0f blue:233.0f/255.0f alpha:1] CGColor],(id)[[UIColor colorWithRed:70.0f/255.0f green:221.0f/255.0f blue:220.0f/255.0f alpha:1] CGColor], nil];
        
        _firstWaveCircle = M_PI*2*_waveNum/WYWIDTH(self);
        _firstCircleTime = (int)((M_PI*2/_firstWaveCircle)/(_waveSpeed));
        firstWaveTime = MAX(0, MIN(1, firstWaveTime));
        _firstWaveTime = (int)(firstWaveTime * (_firstCircleTime));
        _firstVariable = 1;
        _firstIncrease = NO;
        
        [self initContent];
        [self drawWaveOnce];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [[WYWaveView alloc] initWithFrame:frame waveNum:1 waveSpeed:0.05 firstWaveTime:0];
}

#pragma mark - Init

- (void)initContent
{
    [self.layer addSublayer:self.gradientLayer];
}

- (void)resetContent {
    [self.gradientLayer removeFromSuperlayer];
    self.gradientLayer = nil;
}

#pragma mark - Declarations

- (void)startWave
{
    [self.firstWaveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopWave {
    [self.firstWaveDisplayLink invalidate];
    self.firstWaveDisplayLink = nil;
}

#pragma mark - Util

- (void)setWaveLayer
{
    [self firstWaveTimeCount];
    [self animateFirstWave];
    [self drawWaveOnce];
}

- (void)drawWaveOnce {
    self.firstWaveLayer.path = [self getFirstCurrentWavePath];
    [self.gradientLayer setMask:self.firstWaveLayer];
    self.gradientLayer.frame = CGRectMake(0, WYHEIGHT(self)-(self.waveCenterHeight+self.waveAmplitude), WYWIDTH(self), self.waveCenterHeight+self.waveAmplitude);
}

-(void)animateFirstWave
{
    if (_firstIncrease) {
        _firstVariable += 0.01;
    }else{
        _firstVariable -= 0.01;
    }
    
    if (_firstVariable<=0.4) {
        _firstIncrease = YES;
    }
    
    if (_firstVariable>=0.8) {
        _firstIncrease = NO;
    }
}

- (void)firstWaveTimeCount
{
    _firstWaveTime++;
    _firstWaveTime = _firstWaveTime%_firstCircleTime;
}

- (CGMutablePathRef)getFirstCurrentWavePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, self.waveCenterHeight);
    
    float y = 0.0f;
    
    for (float x = 0.0f; x <=  WYWIDTH(self) ; x++) {
        y = self.waveAmplitude + self.waveAmplitude* sin(_firstWaveCircle*x-self.waveSpeed*_firstWaveTime)*_firstVariable;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, WYWIDTH(self), WYHEIGHT(self));
    CGPathAddLineToPoint(path, nil, 0, WYHEIGHT(self));
    CGPathCloseSubpath(path);
    return path;
}


#pragma mark - Setter
- (void)setWaveAmplitude:(CGFloat)waveAmplitude {
    _waveAmplitude = waveAmplitude;
    [self drawWaveOnce];
}

- (void)setWaveCenterHeight:(CGFloat)waveCenterHeight {
    _waveCenterHeight = waveCenterHeight;
    [self drawWaveOnce];
}

- (void)setColors:(NSArray *)colors {
    _colors = colors;
    [self resetContent];
    [self initContent];
    [self drawWaveOnce];
}


#pragma mark - Getter
- (CAShapeLayer *)firstWaveLayer {
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = [UIColor whiteColor].CGColor;
    }
    return _firstWaveLayer;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = CGRectMake(0, WYHEIGHT(self)-(self.waveCenterHeight+self.waveAmplitude), WYWIDTH(self), self.waveCenterHeight+self.waveAmplitude);
        [_gradientLayer setColors:self.colors];
        [_gradientLayer setStartPoint:CGPointMake(0, 0)];
        [_gradientLayer setEndPoint:CGPointMake(0, 1)];
    }
    return _gradientLayer;
}

- (CADisplayLink *)firstWaveDisplayLink {
    if (!_firstWaveDisplayLink) {
        WYWeakProxy *proxy = [WYWeakProxy proxyWithTarget:self];
        _firstWaveDisplayLink = [CADisplayLink displayLinkWithTarget:proxy selector:@selector(setWaveLayer)];
    }
    return _firstWaveDisplayLink;
}
@end
