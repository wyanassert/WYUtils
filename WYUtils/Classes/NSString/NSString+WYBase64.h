//
//  NSString+Base64.h
//  Newsstand
//
//  Created by Carlo Vigiani on 29/Oct/11.
//  Copyright (c) 2011 viggiosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WYBase64)

+ (NSString *) wy_base64StringFromData:(NSData *)data length:(long)length;

@end
