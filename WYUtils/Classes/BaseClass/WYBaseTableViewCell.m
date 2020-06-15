//
//  WYBaseTableViewCell.m
//  GUBaseLib
//
//  Created by Wade Wei on 22/12/2017.
//  Copyright © 2017 makeupopular.com. All rights reserved.
//

#import "WYBaseTableViewCell.h"

@implementation WYBaseTableViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


@end
