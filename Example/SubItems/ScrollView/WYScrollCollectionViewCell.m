//
//  WYScrollCollectionViewCell.m
//  WYUtils_Example
//
//  Created by wyan on 2024/6/28.
//  Copyright © 2024 wyanassert. All rights reserved.
//

#import "WYScrollCollectionViewCell.h"

@interface WYScrollCollectionViewCell ()

@property (nonatomic, strong) UILabel         *titleLabel;

@end

@implementation WYScrollCollectionViewCell

- (void)configSubViews {
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(WXX(10), WXX(10), WXX(200), WXX(30));
}

- (void)loadState:(WYScrollType)viewType
{
    switch (viewType) {
        case WYScrollTypeExposure:
            self.titleLabel.text = @"Exposure";
            break;
        default:
            break;
    }
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = WYColorFromRGB(255, 0, 0);
        label.font = [UIFont systemFontOfSize:WYX(20)];
        label.textAlignment = NSTextAlignmentLeft;
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
