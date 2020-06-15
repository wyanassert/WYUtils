//
//  WYBaseTableViewHeaderFooterView.h
//  GUBaseLib
//
//  Created by Wade Wei on 22/12/2017.
//  Copyright © 2017 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYMacroHeader.h"

@interface WYBaseTableViewHeaderFooterView : UITableViewHeaderFooterView

+ (NSString *)reuseIdentifier;


- (void)configSubViews;


@end
