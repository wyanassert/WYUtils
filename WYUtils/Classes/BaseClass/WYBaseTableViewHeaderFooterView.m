//
//  WYBaseTableViewHeaderFooterView.m
//  GUBaseLib
//
//  Created by Wade Wei on 22/12/2017.
//  Copyright © 2017 makeupopular.com. All rights reserved.
//

#import "WYBaseTableViewHeaderFooterView.h"

@implementation WYBaseTableViewHeaderFooterView

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews
{
    self.backgroundColor = [UIColor clearColor];
}

@end
