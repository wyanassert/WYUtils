//
//  UIFont+WYAllFonts.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/11/26.
//

#import "UIFont+WYAllFonts.h"

@implementation UIFont (WYAllFonts)

+ (NSMutableArray<NSString *> *)wy_allFonts {
    NSArray *array = [UIFont familyNames];
    NSString *familyName ;
    NSMutableArray<NSString *> *fontNames = [[NSMutableArray alloc] init];
    for(familyName in array)  {
        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
        [fontNames addObjectsFromArray:names];
    }
    NSLog(@"%@", fontNames);
    return fontNames;
}

@end
