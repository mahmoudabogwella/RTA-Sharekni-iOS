//
//  NSString+Crypto.m
//  HappinessRating
//
//  Created by Syed Absar Karim on 1/13/15.
//  Copyright (c) 2015 Dubai Smart Government. All rights reserved.
//

#import "NSString+DSGHappinessCrypto.h"

#include <CommonCrypto/CommonDigest.h>

@implementation NSString (DSGHappinessCrypto)

- (NSString *)getSHA512 {
    
    NSString *newString = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData* data = [newString dataUsingEncoding:NSUTF8StringEncoding];

    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSData *sha2 = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    
    NSString *hashString = [sha2 description];
    hashString = [hashString stringByReplacingOccurrencesOfString:@" " withString:@""];
    hashString = [hashString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hashString = [hashString stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    return hashString;
}

@end
