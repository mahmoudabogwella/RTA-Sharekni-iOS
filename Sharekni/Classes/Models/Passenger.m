//
//  Passenger.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/22/15.
//
//

#import "Passenger.h"

@implementation Passenger

+ (NSDictionary *)mapping {
    
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    
    mapping[@"ID"] = @"ID";
    mapping[@"RequestDate"] = @"RequestDate";
    mapping[@"IsRemoved"] = @"IsRemoved";
    mapping[@"RemoveDate"] = @"RemoveDate";
    mapping[@"Remarks"] = @"Remarks";
    mapping[@"AccountId"] = @"AccountId";
    mapping[@"AccountName"] = @"AccountName";
    mapping[@"AccountMobile"] = @"AccountMobile";
    mapping[@"AccountNationalityAr"] = @"AccountNationalityAr";
    mapping[@"AccountNationalityEn"] = @"AccountNationalityEn";
    mapping[@"AccountNationalityFr"] = @"AccountNationalityFr";
    mapping[@"AccountNationalityUr"] = @"AccountNationalityUr";
    mapping[@"AccountNationalityCh"] = @"AccountNationalityCh";
    mapping[@"PassenegerRateByDriver"] = @"PassenegerRateByDriver";

    return mapping;
}
@end
