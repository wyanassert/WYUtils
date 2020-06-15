//
//  WYBaseView.m
//  WanYan
//
//  Created by 李袁野 on 2018/7/24.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import "WYBaseView.h"

@implementation WYBaseView

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews {
    self.backgroundColor = [UIColor clearColor];
}

- (void)addTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

@end
