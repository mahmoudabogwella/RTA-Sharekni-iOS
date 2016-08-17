//
//  Util.m
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import "Util.h"

@implementation Util


+ (NSString *) encodeForString:(NSString *)string {
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *)currentTimestamp {
    
    //15/03/2016 11:02:53
    //generating current timestamp used in application for service calling according to the required pattern of yyyy-MM-dd'T'HH:mm:ss.mmm'Z'"
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"]; //set required time format
    NSDate *now = [NSDate date];
    NSString *timestampString = [dateFormatter stringFromDate:now];
    
    return timestampString;
}

+(NSString *)getJSONString:(NSDictionary *)dictionary {
    
    NSString *jsonString;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

+(NSString *)getRandomString {
    return [[[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""] substringToIndex:16];
}

@end
