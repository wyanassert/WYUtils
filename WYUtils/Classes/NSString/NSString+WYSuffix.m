//
//  NSString+Suffix.m
//  InstaGrab
//
//  Created by stoncle on 12/11/15.
//  Copyright © 2015 JellyKit Inc. All rights reserved.
//

#import "NSString+WYSuffix.h"

@implementation NSString (WYSuffix)

- (NSString *)wy_suffix
{
    NSString *suffix = [[self componentsSeparatedByString:@"."] lastObject];
    return suffix;
}

- (NSString *)wy_generateStringWithSuffix:(NSString *)suffix
{
    if(!suffix || [suffix isEqualToString:@""]) {
        NSLog(@"attempt to add blank suffix.");
        return nil;
    }
    NSString *pureString = [self wy_getPureStringWithoutSuffix];
    return [pureString stringByAppendingString:[NSString stringWithFormat:@".%@", suffix]];
}

- (NSString *)wy_getPureStringWithoutSuffix
{
    NSString *pureString = [[self componentsSeparatedByString:@"."] firstObject];
    return pureString;
}

- (BOOL)wy_isVideoSuffix
{
    NSArray<NSString *> *videoSuffixArray = @[@"mp4", @"mov", @"avi", @"rm", @"rmvb"];
    for (NSString *suffix in videoSuffixArray) {
        if([self hasSuffix:suffix]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)wy_isImageSuffix
{
    NSArray<NSString *> *imageSuffixArray = @[@"png", @"jpg", @"jpeg", @"gif"];
    for (NSString *suffix in imageSuffixArray) {
        if([self hasSuffix:suffix]) {
            return YES;
        }
    }
    return NO;
}

@end
