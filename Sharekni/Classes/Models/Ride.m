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
    
    mapping[@"FromEmirateArName"] = @"FromEmirateArName";
    mapping[@"FromEmirateEnName"] = @"FromEmirateEnName";
    mapping[@"FromEmirateNameFr"] = @"FromEmirateNameFr";
    mapping[@"FromEmirateNameCh"] = @"FromEmirateNameCh";
    mapping[@"FromEmirateNameUr"] = @"FromEmirateNameUr";
    
    mapping[@"ToEmirateArName"] = @"ToEmirateArName";
    mapping[@"ToEmirateEnName"] = @"ToEmirateEnName";
    mapping[@"ToEmirateNameFr"] = @"ToEmirateNameFr";
    mapping[@"ToEmirateNameCh"] = @"ToEmirateNameCh";
    mapping[@"ToEmirateNameUr"] = @"ToEmirateNameUr";
    
    mapping[@"FromRegionArName"] = @"FromRegionArName";
    mapping[@"FromRegionEnName"] = @"FromRegionEnName";
    mapping[@"FromRegionNameFr"] = @"FromRegionNameFr";
    mapping[@"FromRegionNameCh"] = @"FromRegionNameCh";
    mapping[@"FromRegionNameUr"] = @"FromRegionNameUr";
    
    mapping[@"ToRegionArName"] = @"ToRegionArName";
    mapping[@"ToRegionEnName"] = @"ToRegionEnName";
    mapping[@"ToRegionNameFr"] = @"ToRegionNameFr";
    mapping[@"ToRegionNameCh"] = @"ToRegionNameCh";
    mapping[@"ToRegionNameUr"] = @"ToRegionNameUr";

    return mapping;
}

@end