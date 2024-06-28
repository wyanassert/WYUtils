//
//  WYHalfScreenAlertViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2024/6/28.
//  Copyright © 2024 wyanassert. All rights reserved.
//

#import "WYHalfScreenAlertViewController.h"
#import "WYHalfScreenView.h"
#import <Masonry.h>

@interface WYHalfScreenAlertViewController ()

@property (nonatomic, strong) WYHalfScreenView *actionSheetView;

@end

@implementation WYHalfScreenAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton new];
    [btn setBackgroundColor:UIColor.greenColor];
    [btn setTitle:@"弹窗" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.equalTo(self.view);
    }];
}

- (void)clicked
{
    [self.actionSheetView show];
}


- (WYHalfScreenView *)actionSheetView 
{
    if (!_actionSheetView) 
    {
        _actionSheetView = [[WYHalfScreenView alloc] initWithFrame:CGRectMake(0, 0, WY_SCREEN_WIDTH, [WYHalfScreenView actionSheetViewMaxHeight])];
    }
    return _actionSheetView;
}
@end
