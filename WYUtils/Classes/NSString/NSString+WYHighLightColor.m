//
//  NSString+HighColor.m
//  GetX
//
//  Created by wyan assert on 2017/1/22.
//  Copyright © 2017年 JellyKit Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSString+WYHighLightColor.h"

@implementation NSString (WYHighLightColor)

- (NSAttributedString *)wy_getAttributeStingWithHightSubStrings:(NSArray<NSString *> *)subStrings color:(UIColor *)color hightColor:(UIColor *)highLightColor font:(UIFont *)font highLightFont:(UIFont *)highLightFont {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    NSDictionary *attr0 = @{
                            NSForegroundColorAttributeName : color,
                            NSFontAttributeName : font
                            };
    NSDictionary *attr1 = @{
                            NSForegroundColorAttributeName : highLightColor,
                            NSFontAttributeName : highLightFont
                            };
    NSInteger origin = 0;
    for (NSString *tmpStr in subStrings) {
        NSString *localString = [self substringFromIndex:origin];
        NSRange range = [localString rangeOfString:tmpStr];
        if(range.length == 0 || range.location == NSNotFound) {
            
        } else {
            NSString *subString0 = [localString substringToIndex:range.location];
            NSString *subString1 = tmpStr;
            origin += range.location + range.length;
            if(subString0.length) {
                [result appendAttributedString:[[NSAttributedString alloc] initWithString:subString0 attributes:attr0]];
            }
            if(subString1.length) {
                [result appendAttributedString:[[NSAttributedString alloc] initWithString:subString1 attributes:attr1]];
            }
        }
        
    }
    if(origin < self.length) {
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:[self substringFromIndex:origin] attributes:attr0]];
    }
    return [result copy];
}

- (NSAttributedString *)wy_getAttributeStingWithHightSubStrings:(NSArray<NSString *> *)subStrings color:(UIColor *)color highLightColors:(NSArray<UIColor *> *)highLightColors font:(UIFont *)font highLightFonts:(NSArray<UIFont *> *)highLightFonts {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    NSDictionary *attr0 = @{
                                   NSForegroundColorAttributeName : color,
                                   NSFontAttributeName : font
                                   };
    NSMutableDictionary *attr1 = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                 NSForegroundColorAttributeName : highLightColors.count ? highLightColors[0]: [UIColor whiteColor],
                                                                                 NSFontAttributeName : highLightFonts.count ? highLightFonts[0] : [UIFont systemFontOfSize:12]
                                                                                 }];
    NSInteger origin = 0;
    for (NSInteger i = 0; i < subStrings.count; i++) {
        NSString *tmpStr = subStrings[i];
        NSString *localString = [self substringFromIndex:origin];
        NSRange range = [localString rangeOfString:tmpStr];
        if(range.length == 0 || range.location == NSNotFound) {
            
        } else {
            NSString *subString0 = [localString substringToIndex:range.location];
            NSString *subString1 = tmpStr;
            origin += range.location + range.length;
            if(subString0.length) {
                
                [result appendAttributedString:[[NSAttributedString alloc] initWithString:subString0 attributes:attr0]];
            }
            if(subString1.length) {
                if(i < highLightColors.count && i < highLightFonts.count) {
                    [attr1 setObject:highLightColors[i] forKey:NSForegroundColorAttributeName];
                    [attr1 setObject:highLightFonts[i] forKey:NSFontAttributeName];
                }
                [result appendAttributedString:[[NSAttributedString alloc] initWithString:subString1 attributes:[attr1 copy]]];
            }
        }
        
    }
    if(origin < self.length) {
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:[self substringFromIndex:origin] attributes:attr0]];
    }
    return [result copy];
}

@end
