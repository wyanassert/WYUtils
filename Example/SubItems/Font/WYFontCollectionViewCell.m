//
//  WYFontCollectionViewCell.m
//  WYUtils_Example
//
//  Created by wyan on 2023/7/19.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import "WYFontCollectionViewCell.h"

@interface WYFontCollectionViewCell ()

@property (nonatomic, strong) UILabel         *titleLabel;

@end

@implementation WYFontCollectionViewCell

- (void)configSubViews {
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(WXX(10), WXX(10), WXX(300), WXX(30));
}

- (void)loadState:(WYFontType)viewType {
    switch (viewType) {
        case WYFontTypeAllFont:
            self.titleLabel.text = @"ALL Font";
            break;
        default:
            break;
    }
}

- (void)loadText:(NSString *)text fontName:(NSString *)fontName
{
    self.titleLabel.text = text;
    if (fontName.length > 0)
    {
        self.titleLabel.font = [UIFont fontWithName:fontName size:WYX(20)];
    }
}

#pragma mark - Getter

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
