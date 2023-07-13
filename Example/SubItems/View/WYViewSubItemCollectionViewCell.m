//
//  WYViewSubItemCollectionViewCell.m
//  WYUtils_Example
//
//  Created by wyan on 2020/6/15.
//  Copyright © 2020 wyanassert. All rights reserved.
//

#import "WYViewSubItemCollectionViewCell.h"

@interface WYViewSubItemCollectionViewCell ()

@property (nonatomic, strong) UILabel         *titleLabel;

@end

@implementation WYViewSubItemCollectionViewCell

- (void)configSubViews {
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(WXX(10), WXX(10), WXX(200), WXX(30));
}

- (void)loadState:(WYViewType)viewType {
    switch (viewType) {
        case WYViewTypeWave:
            self.titleLabel.text = @"WAVE";
            break;
        case WYViewTypeGravity:
            self.titleLabel.text = @"GRAVITY Motion";
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
