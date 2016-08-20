//
//  Region.m
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import "Region.h"

@implementation Region
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"ID"] = @"ID";
    mapping[@"RegionArName"] = @"RegionArName";
    mapping[@"RegionEnName"] = @"RegionEnName";
    mapping[@"RegionFrName"] = @"RegionFrName";
    mapping[@"RegionChName"] = @"RegionChName";
    mapping[@"RegionUrName"] = @"RegionUrName";
    
    mapping[@"EmirateArName"] = @"EmirateArName";
    mapping[@"EmirateEnName"] = @"EmirateEnName";
    mapping[@"EmirateFrName"] = @"EmirateFrName";
    mapping[@"EmirateChName"] = @"EmirateChName";
    mapping[@"EmirateUrName"] = @"EmirateUrName";
    
    mapping[@"RegionLatitude"] = @"RegionLatitude";
    mapping[@"RegionLongitude"] = @"RegionLongitude";
    return mapping;
}
@end
