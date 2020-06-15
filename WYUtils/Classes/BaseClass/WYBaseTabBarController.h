//
//  WYBaseTabBarController.h
//  GUBaseLib
//
//  Created by K999999999 on 2018/1/15.
//  Copyright © 2018年 K999999999. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYBaseTabBarController : UITabBarController

@property (nonatomic)       BOOL    base_hasPlusButton;
@property (nonatomic, copy) void    (^base_configPlusButtonBlock)(UIButton *plusButton, UIView *contentView);
@property (nonatomic, copy) void    (^base_clickPlusButtonBlock)(UIButton *plusButton);

@end
