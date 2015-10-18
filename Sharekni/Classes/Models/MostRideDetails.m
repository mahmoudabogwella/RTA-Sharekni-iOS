//
//  MostRideDetails.m
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 10/18/15.
//
//

#import "MostRideDetails.h"

@implementation MostRideDetails

+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"RouteId"] = @"RouteId";
    mapping[@"RouteArName"] = @"RouteArName";
    mapping[@"RouteEnName"] = @"RouteEnName";
    mapping[@"NoOfSeats"] = @"NoOfSeats";
    mapping[@"AccountId"] = @"AccountId";
    mapping[@"DriverName"] = @"DriverName";
    mapping[@"Rating"] = @"Rating";
    
    mapping[@"NationalityArName"] = @"NationalityArName";
    mapping[@"NationalityEnName"] = @"NationalityEnName";
    mapping[@"NationalityFrName"] = @"NationalityFrName";
    mapping[@"NationalityChName"] = @"NationalityChName";
    mapping[@"NationalityUrName"] = @"NationalityUrName";
    
    mapping[@"FromEmirateId"] = @"FromEmirateId";
    mapping[@"ToEmirateId"] = @"ToEmirateId";
    mapping[@"FromRegionId"] = @"FromRegionId";
    mapping[@"ToRegionId"] = @"ToRegionId";
    
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
    
    
    mapping[@"CoordinatesStartLat"] = @"CoordinatesStartLat";
    mapping[@"CoordinatesStartLng"] = @"CoordinatesStartLng";
    mapping[@"CoordinatesEndLat"] = @"CoordinatesEndLat";
    mapping[@"CoordinatesEndLng"] = @"CoordinatesEndLng";
    
    mapping[@"Saturday"] = @"Saturday";
    mapping[@"Sunday"] = @"Sunday";
    mapping[@"Monday"] = @"Monday";
    mapping[@"Tuesday"] = @"Tuesday";
    mapping[@"Wendenday"] = @"Wendenday";
    mapping[@"Thrursday"] = @"Thrursday";
    mapping[@"Friday"] = @"Friday";
    
    mapping[@"StartTime"] = @"StartTime";
    mapping[@"EndTime"] = @"EndTime";
    return mapping;
}

@end
