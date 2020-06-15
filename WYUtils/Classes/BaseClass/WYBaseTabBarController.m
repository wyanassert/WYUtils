//
//  WYBaseTabBarController.m
//  GUBaseLib
//
//  Created by K999999999 on 2018/1/15.
//  Copyright © 2018年 K999999999. All rights reserved.
//

#import "WYBaseTabBarController.h"

#import "WYTabBar.h"

@interface WYBaseTabBarController ()

@property (nonatomic, strong)   WYTabBar    *base_tabBar;

@end

@implementation WYBaseTabBarController

#pragma mark - Life Cycle

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _base_hasPlusButton = NO;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self base_refreshTabBar];
}

#pragma mark - Override

- (BOOL)shouldAutorotate {
    
    if (self.selectedViewController) {
        return self.selectedViewController.shouldAutorotate;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    if (self.selectedViewController) {
        return self.selectedViewController.supportedInterfaceOrientations;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    if (self.selectedViewController) {
        return self.selectedViewController.preferredInterfaceOrientationForPresentation;
    }
    return UIInterfaceOrientationPortrait;
}

- (BOOL)prefersStatusBarHidden {
    
    if (self.selectedViewController) {
        return self.selectedViewController.prefersStatusBarHidden;
    }
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (self.selectedViewController) {
        return self.selectedViewController.preferredStatusBarStyle;
    }
    return UIStatusBarStyleDefault;
}

#pragma mark - Private Methods

- (void)base_refreshTabBar {
    
    if (self.base_hasPlusButton) {
        [self setValue:self.base_tabBar forKey:@"tabBar"];
    } else {
        [self setValue:[UITabBar new] forKey:@"tabBar"];
    }
}

#pragma mark - Setters

- (void)setBase_hasPlusButton:(BOOL)base_hasPlusButton {
    
    _base_hasPlusButton = base_hasPlusButton;
    [self base_refreshTabBar];
}

#pragma mark - Getters

- (WYTabBar *)base_tabBar {
    
    if (!_base_tabBar) {
        
        _base_tabBar = [[WYTabBar alloc] init];
        __weak typeof(self)weakSelf = self;
        _base_tabBar.base_configPlusButtonBlock = ^(UIButton *plusButton, UIView *contentView) {
            
            __strong typeof(weakSelf)self = weakSelf;
            if (self.base_configPlusButtonBlock) {
                self.base_configPlusButtonBlock(plusButton, contentView);
            }
        };
        _base_tabBar.base_clickPlusButtonBlock = ^(UIButton *plusButton) {
            
            __strong typeof(weakSelf)self = weakSelf;
            if (self.base_clickPlusButtonBlock) {
                self.base_clickPlusButtonBlock(plusButton);
            }
        };
        [_base_tabBar base_configPlusButton];
    }
    return _base_tabBar;
}

@end
