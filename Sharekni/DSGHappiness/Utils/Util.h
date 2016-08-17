//
//  Util.h
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

/**
 * Encode NSString to UTF-8 Encoding
 * @param string
 * @return
 */
+(NSString *)encodeForString:(NSString *)string;
+(NSString *)currentTimestamp;
+(NSString *)getJSONString:(NSDictionary *)dictionary;
+(NSString *)getRandomString;

@end
