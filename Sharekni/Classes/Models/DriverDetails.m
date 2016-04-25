//
//  DriverDetails.m
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import "DriverDetails.h"

@implementation DriverDetails

+ (NSDictionary *)mapping {
    
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
  
    mapping[@"ID"] = @"ID";
    mapping[@"RouteId"] = @"RouteId";
    mapping[@"RouteArName"] = @"RouteArName";
    mapping[@"RouteEnName"] = @"RouteEnName";
    mapping[@"NoOfSeats"] = @"NoOfSeats";
    mapping[@"AccountId"] = @"AccountId";
    mapping[@"DriverName"] = @"DriverName";
    mapping[@"DriverMobile"] = @"DriverMobile";
    mapping[@"PreferredGender"] = @"PreferredGender";
    mapping[@"Rating"] = @"Rating";
    //GonMade WebServe 2
    mapping[@"RequestStatus"] = @"RequestStatus";

    
    
    mapping[@"AgeRangeId"] = @"AgeRangeId";
    mapping[@"AgeRange"] = @"AgeRange";
    
    mapping[@"NationalityId"] = @"NationalityId";
    mapping[@"NationalityArName"] = @"NationalityArName";
    mapping[@"NationalityEnName"] = @"NationalityEnName";
    mapping[@"NationalityFrName"] = @"NationalityFrName";
    mapping[@"NationalityChName"] = @"NationalityChName";
    mapping[@"NationalityUrName"] = @"NationalityUrName";
    
    mapping[@"PrefLanguageId"] = @"PrefLanguageId";
    mapping[@"PrefLanguageArName"] = @"PrefLanguageArName";
    mapping[@"PrefLanguageEnName"] = @"PrefLanguageEnName";
    mapping[@"PrefLanguageFrName"] = @"PrefLanguageFrName";
    mapping[@"PrefLanguageChName"] = @"PrefLanguageChName";
    mapping[@"PrefLanguageUrName"] = @"PrefLanguageUrName";
    
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
    
    mapping[@"VehicelId"] = @"VehicelId";
    mapping[@"VehicleManuName_ar"] = @"VehicleManuName_ar";
    mapping[@"VehicleManuName_en"] = @"VehicleManuName_en";
    mapping[@"VechilePhoto"] = @"VechilePhoto";
    mapping[@"VehicleNoOfSeats"] = @"VehicleNoOfSeats";
    
    mapping[@"BasisId"] = @"BasisId";
    mapping[@"BasisArName"] = @"BasisArName";
    mapping[@"BasisEnName"] = @"BasisEnName";
    mapping[@"BasisFrName"] = @"BasisFrName";
    mapping[@"BasisChName"] = @"BasisChName";
    mapping[@"BasisUrName"] = @"BasisUrName";

    mapping[@"IsSmoking"] = @"IsSmoking";
    mapping[@"IsRounded"] = @"IsRounded";
    mapping[@"IsPassenger"] = @"IsPassenger";
    
    mapping[@"Saturday"] = @"Saturday";
    mapping[@"Sunday"] = @"Sunday";
    mapping[@"Monday"] = @"Monday";
    mapping[@"Tuesday"] = @"Tuesday";
    mapping[@"Wendenday"] = @"Wendenday";
    mapping[@"Thrursday"] = @"Thrursday";
    mapping[@"Friday"] = @"Friday";
    
    mapping[@"StartTime"] = @"StartTime";
    mapping[@"EndTime"] = @"EndTime";
    mapping[@"StartFromTime"] = @"StartFromTime";
    mapping[@"StartToTime"] = @"StartToTime";
    mapping[@"EndFromTime"] = @"EndFromTime";
    mapping[@"EndToTime"] = @"EndToTime";

    mapping[@"FromStreetName"] = @"FromStreetName";
    mapping[@"ToStreetName"] = @"ToStreetName";
    mapping[@"Remarks"] = @"Remarks";
    
    return mapping;
}

@end








