//
//  AgeRange.m
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 9/27/15.
//
//

#import "AgeRange.h"

@implementation AgeRange
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"RangeId"] = @"RangeId";
    mapping[@"Range"] = @"Range";
    return mapping;
}

@end
