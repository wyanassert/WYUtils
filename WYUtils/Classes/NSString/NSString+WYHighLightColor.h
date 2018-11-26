//
//  NSString+HighColor.h
//  GetX
//
//  Created by wyan assert on 2017/1/22.
//  Copyright © 2017年 JellyKit Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;
@class UIFont;

@interface NSString (WYHighLightColor)

- (NSAttributedString *)wy_getAttributeStingWithHightSubStrings:(NSArray<NSString *> *)subStrings color:(UIColor *)color hightColor:(UIColor *)highLightColor font:(UIFont *)font highLightFont:(UIFont *)highLightFont;

- (NSAttributedString *)wy_getAttributeStingWithHightSubStrings:(NSArray<NSString *> *)subStrings color:(UIColor *)color highLightColors:(NSArray<UIColor *> *)highLightColors font:(UIFont *)font highLightFonts:(NSArray<UIFont *> *)highLightFonts;

@end
