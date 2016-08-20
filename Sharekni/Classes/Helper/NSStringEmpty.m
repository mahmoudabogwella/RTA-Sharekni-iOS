
//
//  NSStringEmpty.m
//  sharekni
//
//  Created by Ahmed Askar on 11/20/15.
//
//

#import "NSStringEmpty.h"

@implementation NSStringEmpty

+ (BOOL)isNullOrEmpty:(NSString *)string
{
    if (string == nil) {
        return YES ;
    }
    
    if (string.length == 0) {
        return YES ;
    }
    
    return NO ;
}

@end
