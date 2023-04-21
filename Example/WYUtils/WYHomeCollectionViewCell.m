//
//  WYHomeCollectionViewCell.m
//  WYUtils_Example
//
//  Created by wyan on 2019/11/27.
//  Copyright © 2019 wyanassert. All rights reserved.
//

#import "WYHomeCollectionViewCell.h"
#import "WYExamplePubHeader.h"

@interface WYHomeCollectionViewCell ()

@property (nonatomic, strong) UIView  *colorView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation WYHomeCollectionViewCell

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
    
    [self.contentView addSubview:self.colorView];
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.mas_equalTo(WYMINSIZE(150, 150));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WYMIN(16));
        make.top.equalTo(self.contentView).offset(WYMIN(30));
        make.size.mas_equalTo(WYMINSIZE(130, 40));
    }];
    
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WYMIN(16));
        make.bottom.equalTo(self.contentView).offset(WYMIN(-10));
        make.size.mas_equalTo(WYMINSIZE(130, 40));
    }];
}

- (void)loadData:(WYHomeType)cellData {
    NSString *descText = @[
        @"Data",
        @"Date",
        @"Object",
        @"Operation",
        @"String",
        @"Color",
        @"Device",
        @"Font",
        @"Image",
        @"Label",
        @"NavigationBar",
        @"View",
        @"TextView",
    ][cellData];
    self.titleLabel.text = descText;
    NSString *allText = [NSString stringWithFormat:@"Select for\n%@", descText];
    self.descLabel.attributedText = [allText wy_getAttributeStingWithHightSubStrings:@[@"Select", descText] color:WYColorFromHex(0xaaaaaa) highLightColors:@[WYColorFromRGB(144, 144, 144), WYColorFromRGBA(44, 44, 44, 0.9)] font:[UIFont systemFontOfSize:13] highLightFonts:@[[UIFont systemFontOfSize:12 weight:UIFontWeightMedium], [UIFont systemFontOfSize:14 weight:UIFontWeightBold]]];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:WYMIN(28)];
        label.textAlignment = NSTextAlignmentLeft;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor greenColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 2;
        _descLabel = label;
    }
    return _descLabel;
}

- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WYMIN(150), WYMIN(150))];
        [_colorView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage wy_imageWithLinearColors:@[(id)WYColorFromHex(0xff69ffd0).CGColor, (id)WYColorFromHex(0xff03d798).CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1) size:WYMINSIZE(150, 150) locations:@[@0, @1]]]];
        [_colorView wy_addRoundedCornerTopLeft:WYMIN(10) topRight:WYMIN(20) bottomLeft:WYMIN(20) bottomRight:WYMIN(40)];
    }
    return _colorView;
}
@end
