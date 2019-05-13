//
//  NSString+WYDecimal.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/5/13.
//

#import "NSString+WYDecimal.h"

@implementation NSString (WYDecimal)

+ (NSString *)wy_decimalStringFromNumber:(NSNumber *)num {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:num];
}

@end
