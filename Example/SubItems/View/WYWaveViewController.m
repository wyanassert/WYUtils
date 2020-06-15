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
}

- (void)configNavi {
    self.base_title = @"Wave";
}

- (void)configView {
    [self.view addSubview:self.waveView];
    [self.waveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (WYWaveView *)waveView {
    if (!_waveView) {
        _waveView = [[WYWaveView alloc] initWithFrame:self.view.bounds];
    }
    return _waveView;
}
@end
