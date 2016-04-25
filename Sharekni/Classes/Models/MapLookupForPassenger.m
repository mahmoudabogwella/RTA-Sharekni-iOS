//
//  MapLookupForPassenger.m
//  sharekni
//
//  Created by killvak on 2/18/16.
//
//


#import "MapLookupForPassenger.h"

@implementation MapLookupForPassenger
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"FromEmirateId"] = @"FromEmirateId";
    mapping[@"FromEmirateArName"] = @"FromEmirateArName";
    mapping[@"FromEmirateEnName"] = @"FromEmirateEnName";
    mapping[@"FromEmirateNameFr"] = @"FromEmirateNameFr";
    mapping[@"FromEmirateNameUr"] = @"FromEmirateNameUr";
    
    mapping[@"FromRegionId"] = @"FromRegionId";
    mapping[@"FromRegionArName"] = @"FromRegionArName";
    mapping[@"FromRegionEnName"] = @"FromRegionEnName";
    mapping[@"FromRegionNameFr"] = @"FromRegionNameFr";
    mapping[@"FromRegionNameCh"] = @"FromRegionNameCh";
    mapping[@"FromRegionNameUr"] = @"FromRegionNameUr";
    
    mapping[@"NoOfRoutes"] = @"NoOfRoutes";
    mapping[@"PassengersCount"] = @"PassengersCount";
    
    mapping[@"FromLat"] = @"FromLat";
    mapping[@"FromLng"] = @"FromLng";
    
    // DriverRouteId ToRegionID ToEmirateID

    mapping[@"DriverRouteId"] = @"DriverRouteId";
    mapping[@"ToRegionId"] = @"ToRegionId";
    mapping[@"ToEmirateId"] = @"ToEmirateId";
    
    return mapping;
}
@end