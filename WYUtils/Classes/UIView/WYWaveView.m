//
//  WYWaveView.m
//  Masonry
//
//  Created by wyan on 2020/6/15.
//

#import "WYWaveView.h"
#import "WYMacroHeader.h"

const static float FirstWaveCenterHeight = 162;
const static float FirstWaveAmplitude = 20.0f;//振幅比例
const static float FirstWaveNum = 1;//容纳曲线循环个数
const static float FirstWaveSpeed = 0.05f;//波浪速度

const static float SecondWaveCenterHeight = 122;
const static float SecondWaveAmplitude = 25.0f;//振幅比例
const static float SecondWaveNum = 0.8;//容纳曲线循环个数
const static float SecondWaveSpeed = 0.06f;//波浪速度

const static float ThirdWaveCenterHeight = 23;
const static float ThirdWaveAmplitude = 11.0f;//振幅比例
const static float ThirdWaveNum = 0.8;//容纳曲线循环个数
const static float ThirdWaveSpeed = 0.06f;//波浪速度
const static float ThirdLineWidth = 2.0f;//线的宽度

@interface WYWaveView ()

@property (strong, nonatomic) CAGradientLayer *firstGradientLayer;
@property (strong, nonatomic) CAShapeLayer *firstWaveLayer;
@property (assign, nonatomic) CGFloat firstWaveCircle;//单位像素周期(由WaveNum计算得出)
@property (assign, nonatomic) int firstWaveTime;
@property (assign, nonatomic) int firstCircleTime;
@property (assign, nonatomic) float firstVariable;     //可变参数 更加真实 模拟波纹
@property (assign, nonatomic) BOOL firstIncrease;      // 增减变化

@property (strong, nonatomic) CAGradientLayer *secondGradientLayer;
@property (strong, nonatomic) CAShapeLayer *secondWaveLayer;
@property (assign, nonatomic) CGFloat secondWaveCircle;//单位像素周期(由WaveNum计算得出)
@property (assign, nonatomic) int secondWaveTime;
@property (assign, nonatomic) int secondCircleTime;
@property (assign, nonatomic) float secondVariable;     //可变参数 更加真实 模拟波纹
@property (assign, nonatomic) BOOL secondIncrease;      // 增减变化

@property (strong, nonatomic) CAGradientLayer *thirdGradientLayer;
@property (strong, nonatomic) CAShapeLayer *thirdWaveLayer;
@property (assign, nonatomic) CGFloat thirdWaveCircle;//单位像素周期(由WaveNum计算得出)
@property (assign, nonatomic) int thirdWaveTime;
@property (assign, nonatomic) int thirdCircleTime;
@property (assign, nonatomic) float thirdVariable;     //可变参数 更加真实 模拟波纹
@property (assign, nonatomic) BOOL thirdIncrease;      // 增减变化

@property (strong, nonatomic) CADisplayLink *firstWaveDisplayLink;

@property (assign, nonatomic) CGFloat BEI6;

@end

@implementation WYWaveView

@synthesize BEI6;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        BEI6 = WY_SCREEN_WIDTH/375;
        
        
        
        _firstWaveCircle = M_PI*2*FirstWaveNum/WY_SCREEN_WIDTH;
        _firstCircleTime = (int)((M_PI*2/_firstWaveCircle)/(FirstWaveSpeed*BEI6));
        _firstWaveTime = 0;
        _firstVariable = 1;
        _firstIncrease = NO;
        
        _secondWaveCircle = M_PI*2*SecondWaveNum/WY_SCREEN_WIDTH;
        _secondCircleTime = (int)((M_PI*2/_secondWaveCircle)/(SecondWaveSpeed*BEI6));
        _secondWaveTime = 2000;
        _secondVariable = 1;
        _secondIncrease = NO;
        
        _thirdWaveCircle = M_PI*2*ThirdWaveNum/WY_SCREEN_WIDTH;
        _thirdCircleTime = (int)((M_PI*2/_thirdWaveCircle)/(ThirdWaveSpeed*BEI6));
        _thirdWaveTime = 3000;
        _thirdVariable = 1;
        _thirdIncrease = NO;
        
        [self initContent];
        
        [self initTimer];
    }
    return self;
}

#pragma mark - Init

- (void)initContent
{
    //第一条波浪线
    _firstWaveLayer = [CAShapeLayer layer];
    _firstWaveLayer.fillColor = [UIColor whiteColor].CGColor;
    
    _firstGradientLayer = [CAGradientLayer layer];
    _firstGradientLayer.frame = CGRectMake(0, WY_SCREEN_HEIGHT-(FirstWaveCenterHeight*BEI6+FirstWaveAmplitude*BEI6), WY_SCREEN_WIDTH, FirstWaveCenterHeight*BEI6+FirstWaveAmplitude*BEI6);
    [_firstGradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithRed:122.0f/255.0f green:95.0f/255.0f blue:233.0f/255.0f alpha:1] CGColor],(id)[[UIColor colorWithRed:70.0f/255.0f green:221.0f/255.0f blue:220.0f/255.0f alpha:1] CGColor], nil]];
    [_firstGradientLayer setStartPoint:CGPointMake(0, 0)];
    [_firstGradientLayer setEndPoint:CGPointMake(0, 1)];
    [_firstGradientLayer setMask:_firstWaveLayer];
    [self.layer addSublayer:_firstGradientLayer];
    
    //第二条波浪线
    _secondWaveLayer = [CAShapeLayer layer];
    _secondWaveLayer.fillColor = [[UIColor whiteColor] CGColor];
    
    _secondGradientLayer = [CAGradientLayer layer];
    _secondGradientLayer.frame = CGRectMake(0,  WY_SCREEN_HEIGHT-(SecondWaveCenterHeight*BEI6+SecondWaveAmplitude*BEI6), WY_SCREEN_WIDTH, SecondWaveCenterHeight*BEI6+SecondWaveAmplitude*BEI6);
    [_secondGradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithRed:156.0f/255.0f green:101.0f/255.0f blue:255.0f/255.0f alpha:1] CGColor],(id)[[UIColor colorWithRed:70.0f/255.0f green:221.0f/255.0f blue:220.0f/255.0f alpha:1] CGColor], nil]];
    [_secondGradientLayer setStartPoint:CGPointMake(0, 0)];
    [_secondGradientLayer setEndPoint:CGPointMake(0, 1)];
    [_secondGradientLayer setMask:_secondWaveLayer];
    [self.layer addSublayer:_secondGradientLayer];
    
    //第三条波浪线
    _thirdWaveLayer = [CAShapeLayer layer];
    _thirdWaveLayer.fillColor = [[UIColor clearColor] CGColor];
    _thirdWaveLayer.strokeColor = [[UIColor redColor] CGColor];
    _thirdWaveLayer.lineCap = kCALineCapRound;
    _thirdWaveLayer.lineWidth = ThirdLineWidth*BEI6;
    [self.layer addSublayer:_thirdWaveLayer];
    
    _thirdGradientLayer = [CAGradientLayer layer];
    _thirdGradientLayer.frame = CGRectMake(0,  WY_SCREEN_HEIGHT-(ThirdWaveCenterHeight*BEI6+ThirdWaveAmplitude*BEI6)-ThirdLineWidth*BEI6, WY_SCREEN_WIDTH, ThirdWaveCenterHeight*BEI6+ThirdWaveAmplitude*BEI6+ThirdLineWidth*BEI6);
    [_thirdGradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithRed:70.0f/255.0f green:221.0f/255.0f blue:220.0f/255.0f alpha:1] CGColor],(id)[[UIColor colorWithRed:122.0f/255.0f green:95.0f/255.0f blue:233.0f/255.0f alpha:1] CGColor],(id)[[UIColor colorWithRed:230.0f/255.0f green:97.0f/255.0f blue:250.0f/255.0f alpha:1] CGColor], nil]];
    [_thirdGradientLayer setStartPoint:CGPointMake(0, 0)];
    [_thirdGradientLayer setEndPoint:CGPointMake(1, 0)];
    [_thirdGradientLayer setMask:_thirdWaveLayer];
    [self.layer addSublayer:_thirdGradientLayer];
}

- (void)initTimer
{
    _firstWaveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setWaveLayer)];
    [self setWaveLayer];
}

#pragma mark - Declarations

- (void)startWave
{
    [_firstWaveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - Util

- (void)setWaveLayer
{
    [self firstWaveTimeCount];
    [self animateFirstWave];
    _firstWaveLayer.path = [self getFirstCurrentWavePath];
    
    [self secondWaveTimeCount];
    [self animateSecondWave];
    _secondWaveLayer.path = [self getSecondCurrentWavePath];
    
    [self thirdWaveTimeCount];
    [self animateThirdWave];
    _thirdWaveLayer.path = [self getThirdCurrentWavePath];
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

-(void)animateSecondWave
{
    if (_secondIncrease) {
        _secondVariable += 0.01;
    }else{
        _secondVariable -= 0.01;
    }
    
    if (_secondVariable<=0.4) {
        _secondIncrease = YES;
    }
    
    if (_secondVariable>=1) {
        _secondIncrease = NO;
    }
}

-(void)animateThirdWave
{
    if (_thirdIncrease) {
        _thirdVariable += 0.01;
    }else{
        _thirdVariable -= 0.01;
    }
    
    if (_thirdVariable<=0.6) {
        _thirdIncrease = YES;
    }
    
    if (_thirdVariable>=1) {
        _thirdIncrease = NO;
    }
}

- (void)firstWaveTimeCount
{
    _firstWaveTime++;
    _firstWaveTime = _firstWaveTime%_firstCircleTime;
}

- (void)secondWaveTimeCount
{
    _secondWaveTime++;
    _secondWaveTime = _secondWaveTime%_secondCircleTime;
}

- (void)thirdWaveTimeCount
{
    _thirdWaveTime++;
    _thirdWaveTime = _thirdWaveTime%_thirdCircleTime;
}

- (CGMutablePathRef)getFirstCurrentWavePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, FirstWaveCenterHeight*BEI6);
    
    float y = 0.0f;
    
    for (float x = 0.0f; x <=  WY_SCREEN_WIDTH ; x++) {
        // 正弦波浪公式
        y = FirstWaveAmplitude*BEI6 + FirstWaveAmplitude*BEI6* sin(_firstWaveCircle*x-FirstWaveSpeed*BEI6*_firstWaveTime)*_firstVariable;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, WY_SCREEN_WIDTH, WY_SCREEN_HEIGHT);
    CGPathAddLineToPoint(path, nil, 0, WY_SCREEN_HEIGHT);
    CGPathCloseSubpath(path);
    return path;
}

- (CGMutablePathRef)getSecondCurrentWavePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, SecondWaveCenterHeight*BEI6);
    
    float y = 0.0f;
    
    for (float x = 0.0f; x <=  WY_SCREEN_WIDTH ; x++) {
        // 正弦波浪公式
        y = SecondWaveAmplitude*BEI6 + SecondWaveAmplitude*BEI6* sin(_secondWaveCircle*x-SecondWaveSpeed*BEI6*_secondWaveTime)*_secondVariable;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, WY_SCREEN_WIDTH, WY_SCREEN_HEIGHT);
    CGPathAddLineToPoint(path, nil, 0, WY_SCREEN_HEIGHT);
    CGPathCloseSubpath(path);
    return path;
}

- (CGMutablePathRef)getThirdCurrentWavePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, ThirdWaveAmplitude*BEI6 + ThirdWaveAmplitude*BEI6 * sin(-ThirdWaveSpeed*BEI6*_thirdWaveTime)*_thirdVariable+ThirdLineWidth*BEI6);
    
    float y = 0.0f;
    
    for (float x = 1.0f; x <=  WY_SCREEN_WIDTH ; x++) {
        // 正弦波浪公式
        y = ThirdWaveAmplitude*BEI6 + ThirdWaveAmplitude*BEI6 * sin(_thirdWaveCircle*x-ThirdWaveSpeed*BEI6*_thirdWaveTime)*_thirdVariable;
        CGPathAddLineToPoint(path, nil, x, y+ThirdLineWidth*BEI6);
    }
    
    return path;
}

@end
