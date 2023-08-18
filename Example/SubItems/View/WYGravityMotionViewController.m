//
//  WYGravityMotionViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2023/7/13.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import "WYGravityMotionViewController.h"
#import "Masonry.h"
#import "UIView+GravityMotion.h"

@interface WYGravityMotionViewController ()

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UILabel *frontLabel;

@end

@implementation WYGravityMotionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.blackColor;
    
//    [self.view addSubview:self.backImageView];
//    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(-100, -200, -100, -200));
//    }];
//
//    {
//        UIView *redView = [[UIView alloc] init];
//        redView.backgroundColor = UIColor.redColor;
//        [self.backImageView addSubview:redView];
//        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.equalTo(self.backImageView);
//            make.width.height.mas_equalTo(50);
//        }];
//    }
//
//    {
//        UIView *redView = [[UIView alloc] init];
//        redView.backgroundColor = UIColor.redColor;
//        [self.backImageView addSubview:redView];
//        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.top.equalTo(self.backImageView);
//            make.width.height.mas_equalTo(100);
//        }];
//    }
//
//    {
//        UIView *redView = [[UIView alloc] init];
//        redView.backgroundColor = UIColor.redColor;
//        [self.backImageView addSubview:redView];
//        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.bottom.equalTo(self.backImageView);
//            make.width.height.mas_equalTo(50);
//        }];
//    }
//
//    {
//        UIView *redView = [[UIView alloc] init];
//        redView.backgroundColor = UIColor.redColor;
//        [self.backImageView addSubview:redView];
//        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.bottom.equalTo(self.backImageView);
//            make.width.height.mas_equalTo(50);
//        }];
//    }
    
    {
        UIView *redView = [[UIView alloc] init];
        redView.backgroundColor = UIColor.redColor;
        [self.view addSubview:redView];
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(100);
            make.width.height.mas_equalTo(200);
        }];
        [redView gm_startRotateWithXAngel:30 yAngel:30 maxXAngel:30 maxYAngel:30];
    }
    
    [self.view addSubview:self.frontLabel];
    [self.frontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.width.height.mas_equalTo(150);
    }];
    
//    [self.backImageView gm_startWithMaxHorizontalOffset:200 maxVerticalOffset:100 maxAngleDx:60 maxAngleDy:60];
//    [self.frontLabel gm_startRotateWithXAngel:10 yAngel:10 maxXAngel:30 maxYAngel:30];
}

- (void)dealloc
{
    [self.backImageView gm_stop];
}

#pragma mark - Getter

- (UILabel *)frontLabel
{
    if (!_frontLabel)
    {
        UILabel *lb = [UILabel new];
        lb.text = @"前景不动\n竖持手机\n背景微动";
        lb.textColor = UIColor.whiteColor;
        lb.font = [UIFont systemFontOfSize:24];
        lb.backgroundColor = [UIColor clearColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.isAccessibilityElement = YES;
        lb.numberOfLines = 3;
        _frontLabel = lb;
    }
    return _frontLabel;
}

- (UIImageView *)backImageView
{
    if (!_backImageView)
    {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"image_star_bg_test"];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.clipsToBounds = YES;
    }
    return _backImageView;
}
@end
