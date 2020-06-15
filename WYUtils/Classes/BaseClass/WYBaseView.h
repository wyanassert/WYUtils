//
//  WYBaseView.h
//  WanYan
//
//  Created by 李袁野 on 2018/7/24.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYMacroHeader.h"

@interface WYBaseView : UIView

+ (NSString *)reuseIdentifier;

- (void)configSubViews;

- (void)addTarget:(nullable id)target action:(nullable SEL)action;

@end
