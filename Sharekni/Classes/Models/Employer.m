//
//  Employer.m
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import "Employer.h"

@implementation Employer
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"ID"] = @"ID";
    mapping[@"EmployerArName"] = @"EmployerArName";
    mapping[@"EmployerEnName"] = @"EmployerEnName";
    mapping[@"EmirateId"] = @"EmirateId";
    mapping[@"EmirateArName"] = @"EmirateArName";
    mapping[@"EmirateEnName"] = @"EmirateEnName";
    mapping[@"EmirateFrName"] = @"EmirateFrName";
    mapping[@"EmirateChName"] = @"EmirateChName";
    mapping[@"EmirateUrName"] = @"EmirateUrName";
    return mapping;
}
@end