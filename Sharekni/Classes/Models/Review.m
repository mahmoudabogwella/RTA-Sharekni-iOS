//
//  Review.m
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import "Review.h"

@implementation Review

+ (NSDictionary *)mapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    
    mapping[@"ReviewId"] = @"ReviewId";
    mapping[@"AccountId"] = @"AccountId";
    mapping[@"AccountName"] = @"AccountName";
    mapping[@"AccountPhoto"] = @"AccountPhoto";
    mapping[@"AccountNationalityAr"] = @"AccountNationalityAr";
    mapping[@"AccountNationalityEn"] = @"AccountNationalityEn";
    mapping[@"AccountNationalityFr"] = @"AccountNationalityFr";
    mapping[@"AccountNationalityUr"] = @"AccountNationalityUr";
    mapping[@"AccountNationalityCh"] = @"AccountNationalityCh";
    return mapping;
}

@end