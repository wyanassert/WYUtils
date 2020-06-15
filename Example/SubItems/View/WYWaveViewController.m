//
//  WYWaveViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2020/6/15.
//  Copyright © 2020 wyanassert. All rights reserved.
//

#import "WYWaveViewController.h"

@interface WYWaveViewController ()

@property (nonatomic, strong) WYWaveView         *waveView;
@property (nonatomic, strong) WYWaveView         *waveView2;

@end

@implementation WYWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configNavi];
    [self configView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.waveView startWave];
    [self.waveView2 startWave];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.waveView stopWave];
}

- (void)dealloc {
    NSLog(@"Dealloc");
}

- (void)configNavi {
    self.base_title = @"Wave";
}

- (void)configView {
    [self.view addSubview:self.waveView];
    [self.view addSubview:self.waveView2];
}


- (WYWaveView *)waveView {
    if (!_waveView) {
        _waveView = [[WYWaveView alloc] initWithFrame:CGRectMake(0, WYDeviceNaviHeight, WXX(375), WXY(200)) waveNum:0.7 waveSpeed:0.05 firstWaveTime:0.40];
        _waveView.waveAmplitude = WXY(20);
        _waveView.waveCenterHeight = WXY(170);
        _waveView.colors = @[(id)UIColor.redColor.CGColor, (id)UIColor.redColor.CGColor];
        _waveView.alpha = 0.7;
    }
    return _waveView;
}

- (WYWaveView *)waveView2 {
    if (!_waveView2) {
        _waveView2 = [[WYWaveView alloc] initWithFrame:CGRectMake(0, WYDeviceNaviHeight, WXX(375), WXY(200)) waveNum:0.7 waveSpeed:0.05 firstWaveTime:0];
        _waveView2.waveAmplitude = WXY(20);
        _waveView2.waveCenterHeight = WXY(160);
        _waveView2.colors = @[(id)UIColor.greenColor.CGColor, (id)UIColor.blueColor.CGColor];
        _waveView2.alpha = 0.7;
    }
    return _waveView2;
}
@end
