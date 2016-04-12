//
//  Encryption.m
//  voiceit out of the box
//
//  Created by Armaan Bindra on 4/20/15.
//  Copyright (c) 2015 VoiceIt Technologies. All rights reserved.
//

#import "Encryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Encryption

+ (NSString *)sha256:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH];

    CC_SHA256(data.bytes, data.length, digest);

    NSMutableString *output =
        [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;
}
@end
