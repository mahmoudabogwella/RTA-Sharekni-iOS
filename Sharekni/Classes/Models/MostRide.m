//
//  MostRide.m
//  Sharekni
//
//  Created by Ahmed Askar on 10/10/15.
//
//

#import "MostRide.h"

@implementation MostRide

+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"FromEmirateNameAr"] = @"FromEmirateNameAr";
    mapping[@"FromEmirateNameEn"] = @"FromEmirateNameEn";
    mapping[@"FromRegionNameAr"] = @"FromRegionNameAr";
    mapping[@"FromRegionNameEn"] = @"FromRegionNameEn";
    mapping[@"ToEmirateNameAr"] = @"ToEmirateNameAr";
    mapping[@"ToEmirateNameEn"] = @"ToEmirateNameEn";
    mapping[@"ToRegionNameAr"] = @"ToRegionNameAr";
    mapping[@"ToRegionNameEn"] = @"ToRegionNameEn";
    
    mapping[@"FromEmirateId"] = @"FromEmirateId";
        mapping[@"ToEmirateId"] = @"ToEmirateId";
        mapping[@"FromRegionId"] = @"FromRegionId";
        mapping[@"ToRegionId"] = @"ToRegionId";
        mapping[@"RoutesCount"] = @"RoutesCount";
    
    return mapping;
}

@end
