//
//  CreatedRide.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/21/15.
//
//

#import "CreatedRide.h"

@implementation CreatedRide

+ (NSDictionary *)mapping {
    
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    
    mapping[@"RouteID"] = @"RouteID";
    mapping[@"Account"] = @"Account";
    mapping[@"Name_ar"] = @"Name_ar";
    mapping[@"Name_en"] = @"Name_en";
    mapping[@"Vehicle_ManufactureModel_ar"] = @"Vehicle_ManufactureModel_ar";
    mapping[@"Vehicle_ManufactureModel_en"] = @"Vehicle_ManufactureModel_en";
    mapping[@"Vehicle_ManufactureName_ar"] = @"Vehicle_ManufactureName_ar";
    mapping[@"Vehicle_ManufactureName_en"] = @"Vehicle_ManufactureName_en";
    mapping[@"NoOfSeats"] = @"NoOfSeats";
    mapping[@"NoOfSeatsAvailable"] = @"NoOfSeatsAvailable";
    
    mapping[@"FromEmirateId"] = @"FromEmirateId";
    mapping[@"FromEmirateArName"] = @"FromEmirateArName";
    mapping[@"FromEmirateEnName"] = @"FromEmirateEnName";
    mapping[@"FromEmirateFrName"] = @"FromEmirateFrName";
    mapping[@"FromEmirateChName"] = @"FromEmirateChName";
    mapping[@"FromEmirateUrName"] = @"FromEmirateUrName";
    
    mapping[@"ToEmirateId"] = @"ToEmirateId";
    mapping[@"ToEmirateArName"] = @"ToEmirateArName";
    mapping[@"ToEmirateEnName"] = @"ToEmirateEnName";
    mapping[@"ToEmirateFrName"] = @"ToEmirateFrName";
    mapping[@"ToEmirateChName"] = @"ToEmirateChName";
    mapping[@"ToEmirateUrName"] = @"ToEmirateUrName";
    
    mapping[@"FromRegionId"] = @"FromRegionId";
    mapping[@"FromRegionArName"] = @"FromRegionArName";
    mapping[@"FromRegionEnName"] = @"FromRegionEnName";
    mapping[@"FromRegionFrName"] = @"FromRegionFrName";
    mapping[@"FromRegionChName"] = @"FromRegionChName";
    mapping[@"FromRegionUrName"] = @"FromRegionUrName";
    
    mapping[@"ToRegionId"] = @"ToRegionId";
    mapping[@"ToRegionArName"] = @"ToRegionArName";
    mapping[@"ToRegionEnName"] = @"ToRegionEnName";
    mapping[@"ToRegionFrName"] = @"ToRegionFrName";
    mapping[@"ToRegionChName"] = @"ToRegionChName";
    mapping[@"ToRegionUrName"] = @"ToRegionUrName";
    return mapping;
}
@end
