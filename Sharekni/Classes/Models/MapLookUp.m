//
//  MapLookUp.m
//  Sharekni
//
//  Created by Ahmed Askar on 10/11/15.
//
//

#import "MapLookUp.h"

@implementation MapLookUp
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"FromEmirateId"] = @"FromEmirateId";
    mapping[@"FromEmirateNameAr"] = @"FromEmirateNameAr";
    mapping[@"FromEmirateNameEn"] = @"FromEmirateNameEn";
    mapping[@"FromEmirateNameFr"] = @"FromEmirateNameFr";
    mapping[@"FromEmirateNameUr"] = @"FromEmirateNameUr";
    
    mapping[@"FromRegionId"] = @"FromRegionId";
    mapping[@"FromRegionNameAr"] = @"FromRegionNameAr";
    mapping[@"FromRegionNameEn"] = @"FromRegionNameEn";
    mapping[@"FromRegionNameFr"] = @"FromRegionNameFr";
    mapping[@"FromRegionNameCh"] = @"FromRegionNameCh";
    mapping[@"FromRegionNameUr"] = @"FromRegionNameUr";
    
    mapping[@"NoOfRoutes"] = @"NoOfRoutes";
    mapping[@"NoOfPassengers"] = @"NoOfPassengers";
    
    mapping[@"FromLat"] = @"FromLat";
    mapping[@"FromLng"] = @"FromLng";
    
    return mapping;
}
@end