//
//  WYScrollCollectionViewCell.h
//  WYUtils_Example
//
//  Created by wyan on 2024/6/28.
//  Copyright © 2024 wyanassert. All rights reserved.
//

#import <WYUtils/WYUtils.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WYScrollType) {
    WYScrollTypeExposure,
    WYScrollTypeCount,
};

@interface WYScrollCollectionViewCell : WYBaseCollectionViewCell

- (void)loadState:(WYScrollType)viewType;

@end

NS_ASSUME_NONNULL_END
