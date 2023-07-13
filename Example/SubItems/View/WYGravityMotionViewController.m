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
    
    [self.view addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(-50, -50, -50, -50));
    }];
    
    [self.view addSubview:self.frontLabel];
    [self.frontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.backImageView gm_startWithSpeed:1 maxHorizontalOffset:50 maxVerticalOffset:50];
    [self.frontLabel gm_startWithSpeed:0.3 maxHorizontalOffset:50 maxVerticalOffset:50];
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
        lb.text = @"前景不动,  竖持手机, 微动背景跟着动";
        lb.textColor = UIColor.whiteColor;
        lb.font = [UIFont systemFontOfSize:24];
        lb.backgroundColor = [UIColor clearColor];
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
