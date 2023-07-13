//
//  WYViewSubItemCollectionViewCell.h
//  WYUtils_Example
//
//  Created by wyan on 2020/6/15.
//  Copyright © 2020 wyanassert. All rights reserved.
//

#import <WYUtils/WYUtils.h>

typedef NS_ENUM(NSUInteger, WYViewType) {
    WYViewTypeWave,
    WYViewTypeGravity,
    WYViewTypeCount,
};

NS_ASSUME_NONNULL_BEGIN

@interface WYViewSubItemCollectionViewCell : WYBaseCollectionViewCell

- (void)loadState:(WYViewType)viewType;

@end

NS_ASSUME_NONNULL_END
