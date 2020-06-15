//
//  WYBaseCollectionViewCell.m
//  GxUniversal
//
//  Created by Wade Wei on 23/11/2017.
//  Copyright © 2017 makeupopular.com. All rights reserved.
//

#import "WYBaseCollectionViewCell.h"

@implementation WYBaseCollectionViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews
{
    self.contentView.backgroundColor = [UIColor clearColor];
}

@end
