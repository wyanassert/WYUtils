//
//  WYTabBar.h
//  WanYan
//
//  Created by 李袁野 on 2018/7/24.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYTabBar : UITabBar

@property (nonatomic, copy)     void        (^base_configPlusButtonBlock)(UIButton *plusButton, UIView *contentView);
@property (nonatomic, copy)     void        (^base_clickPlusButtonBlock)(UIButton *plusButton);
@property (nonatomic, strong)   UIButton    *base_plusButton;

- (void)base_configPlusButton;

@end
