//
//  WYHomeCollectionViewCell.h
//  WYUtils_Example
//
//  Created by wyan on 2019/11/27.
//  Copyright © 2019 wyanassert. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WYHomeType) {
    WYHomeTypeData,
    WYHomeTypeDate,
    WYHomeTypeObject,
    WYHomeTypeOperation,
    WYHomeTypeString,
    WYHomeTypeColor,
    WYHomeTypeDevice,
    WYHomeTypeFont,
    WYHomeTypeImage,
    WYHomeTypeLabel,
    WYHomeTypeNavigationBar,
    WYHomeTypeView,
    WYHomeTypeTextView,
    WYHomeTypeCount
};

@interface WYHomeCollectionViewCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;

- (void)loadData:(WYHomeType)cellData;

@end

NS_ASSUME_NONNULL_END
