//
//  WYFlipClockViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2023/8/18.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import "WYFlipClockViewController.h"
#import "WYFlipClockView.h"

@interface WYFlipClockViewController ()

@property (nonatomic, strong) WYFlipClockView *flipClockView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WYFlipClockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.flipClockView];
    self.flipClockView.frame = CGRectMake(20, 100, 300, 80);
    [self updateTimeLabel];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(updateTimeLabel)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)updateTimeLabel
{
    self.flipClockView.date = [NSDate date];
}


- (WYFlipClockView *)flipClockView
{
    if (!_flipClockView)
    {
        _flipClockView = [[WYFlipClockView alloc] init];
        _flipClockView.currFont = [UIFont systemFontOfSize:50 weight:UIFontWeightMedium];
        _flipClockView.currTextColor = UIColor.blackColor;
        _flipClockView.currBackgroudColor = UIColor.whiteColor;
    }
    return _flipClockView;
}
@end
