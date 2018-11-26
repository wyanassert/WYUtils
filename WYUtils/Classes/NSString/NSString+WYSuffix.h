//
//  NSString+Suffix.h
//  InstaGrab
//
//  Created by stoncle on 12/11/15.
//  Copyright © 2015 JellyKit Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WYSuffix)

@property (nonatomic, readonly, copy) NSString *wy_suffix;

- (NSString *)wy_generateStringWithSuffix:(NSString *)suffix;

- (NSString *)wy_getPureStringWithoutSuffix;

- (BOOL)wy_isVideoSuffix;

- (BOOL)wy_isImageSuffix;

@end
