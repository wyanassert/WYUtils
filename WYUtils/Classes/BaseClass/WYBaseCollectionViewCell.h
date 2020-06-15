//
//  GXBaseCollectionViewCell.h
//  GxUniversal
//
//  Created by Wade Wei on 23/11/2017.
//  Copyright © 2017 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYMacroHeader.h"

@interface WYBaseCollectionViewCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;

- (void)configSubViews;

@end
