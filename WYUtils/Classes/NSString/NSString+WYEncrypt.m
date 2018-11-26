//
//  NSString+JKEncrypt.m
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/1/26.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

// 加密解密工具 http://tool.chacuo.net/cryptdes
#import "NSString+WYEncrypt.h"
#import "NSData+WYEncrypt.h"
#import "NSData+WYBase64.h"

@implementation NSString (JKEncrypt)
-(NSString*)wy_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] wy_encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted wy_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)wy_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData wy_dataWithBase64EncodedString:self] wy_decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)wy_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] wy_encryptedWithDESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted wy_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)wy_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData wy_dataWithBase64EncodedString:self] wy_decryptedWithDESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)wy_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] wy_encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted wy_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)wy_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData wy_dataWithBase64EncodedString:self] wy_decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

@end
