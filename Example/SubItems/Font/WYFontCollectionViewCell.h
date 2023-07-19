//
//  WYFontCollectionViewCell.h
//  WYUtils_Example
//
//  Created by wyan on 2023/7/19.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import <WYUtils/WYUtils.h>

typedef NS_ENUM(NSUInteger, WYFontType) {
    WYFontTypeAllFont,
    WYFontTypeCount,
};

NS_ASSUME_NONNULL_BEGIN

@interface WYFontCollectionViewCell : WYBaseCollectionViewCell

- (void)loadState:(WYFontType)viewType;

- (void)loadText:(NSString *)text fontName:(NSString *)fontName;

@end

NS_ASSUME_NONNULL_END
