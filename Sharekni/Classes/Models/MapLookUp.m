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
    mapping[@"ID"] = @"ID";
    mapping[@"RouteArName"] = @"RouteArName";
    mapping[@"RouteEnName"] = @"RouteEnName";
    mapping[@"PreferredGender"] = @"PreferredGender";
    mapping[@"IsSmoking"] = @"IsSmoking";
    mapping[@"NoOfSeats"] = @"NoOfSeats";
    
    mapping[@"StartFromTime"] = @"StartFromTime";
    mapping[@"StartToTime"] = @"StartToTime";
    mapping[@"EndFromTime"] = @"EndFromTime";
    mapping[@"EndToTime"] = @"EndToTime";
    
    mapping[@"IsRounded"] = @"IsRounded";
    mapping[@"IsPassenger"] = @"IsPassenger";

    
    mapping[@"EmployerID"] = @"EmployerID";
    
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
    mapping[@"ToRegionUrName"] = @"ToRegionUrName";
    
    mapping[@"Rating"] = @"Rating";
    
    mapping[@"FromStreetName"] = @"FromStreetName";
    mapping[@"ToStreetName"] = @"ToStreetName";
    mapping[@"Remarks"] = @"Remarks";
    mapping[@"AccountId"] = @"AccountId";


    mapping[@"BasisId"] = @"BasisId";
    mapping[@"BasisArName"] = @"BasisArName";
    mapping[@"BasisEnName"] = @"BasisEnName";
    mapping[@"BasisUrName"] = @"BasisUrName";
    mapping[@"BasisChName"] = @"BasisChName";
    mapping[@"BasisFrName"] = @"BasisFrName";
    
    mapping[@"RouteId"] = @"RouteId";
    mapping[@"VehicelId"] = @"VehicelId";
    
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
    
    mapping[@"StartLatitude"] = @"StartLatitude";
    mapping[@"EndLatitude"] = @"EndLatitude";
    mapping[@"StartLongitude"] = @"StartLongitude";
    mapping[@"EndLongitude"] = @"EndLongitude";
    
    mapping[@"Saturday"] = @"Saturday";
    mapping[@"Sunday"] = @"Sunday";
    mapping[@"Monday"] = @"Monday";
    mapping[@"Tuesday"] = @"Tuesday";
    mapping[@"Wendenday"] = @"Wendenday";
    mapping[@"Thrursday"] = @"Thrursday";
    mapping[@"Friday"] = @"Friday";

    return mapping;
}
@end