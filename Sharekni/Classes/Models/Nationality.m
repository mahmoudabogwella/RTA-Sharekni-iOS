//
//  Nationality.m
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import "Nationality.h"

@implementation Nationality
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"ID"] = @"ID";
    mapping[@"NationalityArName"] = @"NationalityArName";
    mapping[@"NationalityEnName"] = @"NationalityEnName";
    mapping[@"NationalityFrName"] = @"NationalityFrName";
    mapping[@"NationalityChName"] = @"NationalityChName";
    mapping[@"NationalityUrName"] = @"NationalityUrName";
    return mapping;
}
@end
