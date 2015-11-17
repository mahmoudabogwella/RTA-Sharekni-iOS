//
//  Ride.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/17/15.
//
//

#import "Ride.h"

@implementation Ride
+ (NSDictionary *)mapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    
    mapping[@"RoutePassengerId"] = @"RoutePassengerId";
    mapping[@"DriverAccept"] = @"DriverAccept";
    mapping[@"RouteID"] = @"RouteID";
    mapping[@"DriverId"] = @"DriverId";
    mapping[@"RouteArName"] = @"RouteArName";
    mapping[@"RouteEnName"] = @"RouteEnName";
    mapping[@"JoinDate"] = @"JoinDate";
    mapping[@"DriverMobile"] = @"DriverMobile";
    mapping[@"DriverName"] = @"DriverName";
    mapping[@"DriverPhoto"] = @"DriverPhoto";
    mapping[@"DriverNationalityId"] = @"DriverNationalityId";
    mapping[@"DriverNationalityArName"] = @"DriverNationalityArName";
    mapping[@"DriverNationalityEnName"] = @"DriverNationalityEnName";
    mapping[@"DriverNationalityFrName"] = @"DriverNationalityFrName";
    mapping[@"DriverNationalityChName"] = @"DriverNationalityChName";
    mapping[@"DriverNationalityUrName"] = @"DriverNationalityUrName";
    return mapping;
}

@end