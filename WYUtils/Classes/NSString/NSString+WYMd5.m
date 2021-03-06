//
//  NSString+Md5.m
//  InstaGrab
//
//  Created by stoncle on 12/11/15.
//  Copyright © 2015 JellyKit Inc. All rights reserved.
//

#import "NSString+WYMd5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (WYMd5)

- (NSString *)wy_MD5String
{
    if ([self length] <= 0) { return nil; }
    
    const char *cStringToHash = [self UTF8String];
    unsigned char hash[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStringToHash, (CC_LONG)(strlen(cStringToHash)), hash);
    
    NSMutableString *hashString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
    {
        [hashString appendFormat:@"%02X", hash[i]];
    }
    NSString *result = [NSString stringWithString:hashString];
    return result;
}

@end
